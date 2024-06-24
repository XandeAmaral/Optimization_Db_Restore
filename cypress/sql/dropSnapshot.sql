BEGIN TRY
  DECLARE @sqlCommand NVARCHAR(128);
  DECLARE @snapshotName NVARCHAR(128);
  DECLARE snapshot_cursor CURSOR FOR
  SELECT db_name(db.database_id) as snapshot_name FROM sys.databases db
    INNER JOIN sys.master_files mf
      ON db.database_id = mf.database_id
    WHERE db.source_database_id is not null
      AND mf.is_sparse = 1
      AND db_name(db.source_database_id) 
        IN ('$(nomeBanco)');

  OPEN snapshot_cursor;
  FETCH NEXT FROM snapshot_cursor INTO @snapshotName;

  WHILE @@FETCH_STATUS = 0
  BEGIN
    SET @sqlCommand = 'DROP DATABASE ' + @snapshotName;
    EXEC sp_executesql @sqlCommand;
    PRINT 'SUCCESS DROP';

    FETCH NEXT FROM snapshot_cursor INTO @snapshotName;
  END;

  CLOSE snapshot_cursor;
  DEALLOCATE snapshot_cursor;
END TRY
BEGIN CATCH
    DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
    PRINT 'Falha ao tentar excluir snapshots. Detalhes do erro:';
    PRINT 'Mensagem de erro: ' + @ErrorMessage;
    PRINT 'Linha com erro: ' + CAST(ERROR_LINE() AS NVARCHAR(10));
END CATCH;
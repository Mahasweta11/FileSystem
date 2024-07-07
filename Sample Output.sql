SELECT 
    f.NodeID,
    f.NodeName,
    COALESCE(
        (
            SELECT SUM(COALESCE(fs.SizeBytes, 0))
            FROM FileSystem fs
            WHERE fs.NodeID = f.NodeID
               OR fs.ParentID = f.NodeID
               OR fs.ParentID IN (
                    SELECT fs1.NodeID
                    FROM FileSystem fs1
                    WHERE fs1.ParentID = f.NodeID
               )
               OR fs.ParentID IN (
                    SELECT fs2.NodeID
                    FROM FileSystem fs2
                    WHERE fs2.ParentID IN (
                        SELECT fs1.NodeID
                        FROM FileSystem fs1
                        WHERE fs1.ParentID = f.NodeID
                    )
               )
        ),
        0
    ) AS SizeBytes
FROM 
    FileSystem f
ORDER BY 
    f.NodeID;

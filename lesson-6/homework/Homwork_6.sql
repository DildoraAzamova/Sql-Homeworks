

----PUZZLE 1---

SELECT  DISTINCt col1, col2 from InputTbl
GROUP BY col1, col2

SELECT 
    CASE WHEN col1 < col2 THEN col1 ELSE col2 END AS col1,
    CASE WHEN col1 < col2 THEN col2 ELSE col1 END AS col2
FROM InputTbl
GROUP BY 
    CASE WHEN col1 < col2 THEN col1 ELSE col2 END,
    CASE WHEN col1 < col2 THEN col2 ELSE col1 END;

----PUZZLE 2---

SELECT *
FROM TestMultipleZero
WHERE A<>0 OR B<>0 OR C<>0 OR D<>0;

----PUZZLE 3---

SELECT * FROM section1
WHERE id % 2 = 1;

----PUZZLE 4 ---

SELECT TOP 1*
FROM section1
ORDER BY id ASC

----PUZZLE 5 ---

SELECT TOP 1 *
FROM section1
ORDER BY id DESC 

----PUZZLE 6 ---

SELECT * FROM section1
WHERE name LIKE 'b%'

----PUZZLE 7 ---

SELECT * FROM ProductCodes
WHERE code LIKE '%\_%' ESCAPE '\';
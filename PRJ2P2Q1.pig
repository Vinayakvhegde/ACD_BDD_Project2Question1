REGISTER /home/acadgild/Downloads/pig_xml.jar ;
REGISTER /home/acadgild/Downloads/UDF_CalcPercentage.jar ;

Govt_data = LOAD '/flume_sink/FlumeData.1469545565013' USING pig.XML.newloader('row') AS (RawData : chararray) ;

Govt_Data_In = FOREACH Govt_data GENERATE FLATTEN(REGEX_EXTRACT_ALL(RawData,'<row>\\s*<State_Name>(.*)</State_Name>\\s*<District_Name>(.*)</District_Name>\\s*<Project_Objectives_IHHL_BPL>(.*)</Project_Objectives_IHHL_BPL>\\s*<Project_Objectives_IHHL_APL>(.*)</Project_Objectives_IHHL_APL>\\s*<Project_Objectives_IHHL_TOTAL>(.*)</Project_Objectives_IHHL_TOTAL>\\s*<Project_Objectives_SCW>(.*)</Project_Objectives_SCW>\\s*<Project_Objectives_School_Toilets>(.*)</Project_Objectives_School_Toilets>\\s*<Project_Objectives_Anganwadi_Toilets>(.*)</Project_Objectives_Anganwadi_Toilets>\\s*<Project_Objectives_RSM>(.*)</Project_Objectives_RSM>\\s*<Project_Objectives_PC>(.*)</Project_Objectives_PC>\\s*<Project_Performance-IHHL_BPL>(.*)</Project_Performance-IHHL_BPL>\\s*<Project_Performance-IHHL_APL>(.*)</Project_Performance-IHHL_APL>\\s*<Project_Performance-IHHL_TOTAL>(.*)</Project_Performance-IHHL_TOTAL>\\s*<Project_Performance-SCW>(.*)</Project_Performance-SCW>\\s*<Project_Performance-School_Toilets>(.*)</Project_Performance-School_Toilets>\\s*<Project_Performance-Anganwadi_Toilets>(.*)</Project_Performance-Anganwadi_Toilets>\\s*<Project_Performance-RSM>(.*)</Project_Performance-RSM>\\s*<Project_Performance-PC>(.*)</Project_Performance-PC>\\s*</row>')) ;

Filtered_Districts = FOREACH Govt_Data_In GENERATE $1 AS District_Name, udf_project2.PecentageUDF($2, $10) AS percentage ;

List_Of_Districts = FILTER Filtered_Districts BY ((int)percentage == 80) ;

STORE List_Of_Districts INTO 'prj2/AnswerQ2' ;

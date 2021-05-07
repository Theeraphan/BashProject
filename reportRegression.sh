#################################################################################
#                        Develop for personal use                               # 
# Author: Theeraphan Krittayanurak                                              #
# How:./reportRegress.sh 20210425_20210507114515 20210425_20210507122557 >output#
#-------------------------------------------------------------------------------#
# Date      |Version  |Detail                                                   #
#-------------------------------------------------------------------------------#
# 2021-05-07|1.0.0    |sdiff all report in current (csv)                        #
#                                                                               #
#################################################################################
#!/bin/bash
. ../config/general_config.property
mig1=$1
mig2=$2
echo "##################"
echo "CHECK MAIN FOLDER"
echo "##################"
for file in $REPORT_DIR/reports_${mig1}/*.csv
do
  file_name=${file%.csv}
  sdiff $REPORT_DIR/reports_${mig1}/${filename} $REPORT_DIR/reports_${mig2}/${filename}
done

echo "##################"
echo "CHECK SUBFOLDER 1 "
echo "##################"

declare -a rep_folder
rep_folder=( "03_Condition_Failed_Records"
"04_E-Matching_Data"
"04_Non_Migrated_Records"
"05_Rejected_Records"
"06_Cascade_table"
"DVT_reports"
"iSprint"
"rm_lists"
)
for folder in ${rep_folder[@]}
do
  _folder=${folder}
  echo "##########################################################################"
  echo "folder name: $_folder"
  echo "##########################################################################"
  for file in $REPORT_DIR/reports_${mig1}/${_folder}/*
  do
    _file=${file}
    echo "####################################################################################################################################################"
    echo "file in folder: ${_file}"
    echo "####################################################################################################################################################"
    if [[ ${_file} == *".csv" ]]; then
      file_name=${_file%.csv}
      echo "start diff csv:"
      echo "${file_name}"
      sdiff $REPORT_DIR/reports_${mig1}/${_folder}/${filename} $REPORT_DIR/reports_${mig2}/${_folder}/${filename}
    else
      if [[ ${_file} == *".xlsx" ]]; then
        xfile=$(basename $_file)
        echo "Count diff on"
        echo " $(wc $REPORT_DIR/reports_${mig1}/${_folder}/${xfile}) <=>  $( wc $REPORT_DIR/reports_${mig2}/${_folder}/${xfile})"
        #wc -l $REPORT_DIR/reports_${mig1}/${_folder}/${xfile} &&  wc -l $REPORT_DIR/reports_${mig2}/${_folder}/${xfile};
      fi
    fi
  done
done

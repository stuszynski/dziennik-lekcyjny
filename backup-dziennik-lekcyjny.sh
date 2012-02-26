#! /bin/bash

mongoexport -d dziennik_lekcyjny_development -c users -o users-$(date +%Y-%m-%d).json
mongoexport -d dziennik_lekcyjny_development -c students -o students-$(date +%Y-%m-%d).json

mongoexport --csv  -f first_name,last_name,class_name,group,year,semester,uid \
  -d dziennik_lekcyjny_development -c students -o students-$(date +%Y-%m-%d).csv

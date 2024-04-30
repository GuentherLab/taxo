## script for putting all transcripts from each session from all subjects into a single folder
#
# each subject directory is assumed to contain CHAT transcript files formatted as SUB-SES.cha .....
# ..... where SUB = subject ID (3-digit number), SES = session number (1-digit number)
#
# transcripts will be copied into ../taxo/derivatives/ISSRP/sourcedata_by_visit

###### paths and params
PATH_BASE <- "C:\\docs\\code\\taxo"
PATH_SOURCE <- paste0(PATH_BASE, "\\sourcedata\\IISRP")
PATH_DER <- paste0(PATH_BASE, "\\derivatives\\IISRP")
PATH_VISITs_TOP <- paste0(PATH_DER, "\\sourcedata_by_visit")

# do not copy the following subjects (non-English speakers... causes error in CLAN)
non_english_subs <- list("046","049")

# the following list should match names of group subdirectories in PATH_SOURCE
subj_groups <- list("CWNS", "CWS-per", "CWS-rec") 

############### organize session transcripts
# check for / create derivatives for this project
if (!dir.exists(PATH_DER)) {
  # If it doesn't exist, create it
  dir.create(PATH_DER, recursive = TRUE)
  cat(paste("\n Directory", PATH_DER, "created. \n"))
}

nsubgroups <- length(subj_groups)
for (igroup in 1:nsubgroups) {
  thisgroup <-  subj_groups[igroup]
  group_source_dir <- paste0(PATH_SOURCE, "\\", thisgroup)
  subj_dirs <- normalizePath(list.dirs(group_source_dir, recursive = FALSE))
  for (thissubdir in subj_dirs) {
    thissubname <- substr(thissubdir, nchar(thissubdir)-2, nchar(thissubdir))
    
      if  (!(thissubname %in% non_english_subs)) { # if subject is English speaker
          thissub_xscripts <- list.files(thissubdir, pattern = "\\.cha$")
          for (this_visit_file in thissub_xscripts) { # for each visit file in this subject
            visitnum <- sub(".*-(.*)\\.cha", "\\1", this_visit_file)
            recipient_dir <- normalizePath(file.path(PATH_VISITs_TOP, paste0("visit-",visitnum)))
            file_to_copy <- paste0(thissubdir,"\\",this_visit_file)
            
            if (!dir.exists(recipient_dir)) {
              dir.create(recipient_dir, recursive = TRUE) # If this visit dir doesn't exist, create it
            }
            file.copy(file_to_copy,recipient_dir) # copy transcript into visit dir
        }
    }
  }
}


library(quanteda) ; library(DT)
library(stringi)
library(data.table)
library(dplyr)
library(tm)




Wd_pred<- function(t_str) {
        t_str_split <- unlist(strsplit(Clean_TeSt(t_str),split=" "))
        t_str_length <- length(t_str_split)
        
        QG_ck<- NULL
        TG_ck<- NULL
        BG_ck<- NULL
        if (t_str_length >= 3)
        {
                t_str_check <- paste(t_str_split[(t_str_length-2):t_str_length], collapse=" ");
                QG_ck <- df_qg[grep(paste("^",t_str_check, sep = ""), df_qg$terms), ]
                if (length(QG_ck[, 1]) >= 1){ 
                        xx<- sum(QG_ck$freq)
                        QG_ck$disc <- QG_ck$freq*(0.5/xx)
                }
                t_str_check <- paste(t_str_split[(t_str_length-1):t_str_length], collapse=" ");
                TG_ck <- df_tg[grep(paste("^",t_str_check, sep = ""), df_tg$terms), ]
                if (length(TG_ck[, 1]) >= 1){ 
                        xx<- sum(TG_ck$freq)
                        TG_ck$disc <- TG_ck$freq*(0.3/xx)
                } 
                BG_ck <- df_bg[grep(paste("^",t_str_split[t_str_length], sep = ""), df_bg$terms), ]
                if (length(BG_ck[, 1]) >= 1){ 
                        xx<- sum(BG_ck$freq)
                        BG_ck$disc <- BG_ck$freq*(0.2/xx)
                } 
        }
        
        if (t_str_length == 2)
        {
                t_str_check <- paste(t_str_split[(t_str_length-1):t_str_length], collapse=" ");
                TG_ck <- df_tg[grep(paste("^",t_str_check, sep = ""), df_tg$terms), ]
                if (length(TG_ck[, 1]) >= 1){ 
                        xx<- sum(TG_ck$freq)
                        TG_ck$disc <- TG_ck$freq*(0.8/xx)
                } 
                BG_ck <- df_bg[grep(paste("^",t_str_split[t_str_length], sep = ""), df_bg$terms), ]
                if (length(BG_ck[, 1]) >= 1){ 
                        xx<- sum(BG_ck$freq)
                        BG_ck$disc <- BG_ck$freq*(0.2/xx)
                } 
        }
        
        if (t_str_length == 1)
        {
                BG_ck <- df_bg[grep(paste("^",t_str_split[t_str_length], sep = ""), df_bg$terms), ]
                if (length(BG_ck[, 1]) >= 1){ 
                        xx<- sum(BG_ck$freq)
                        BG_ck$disc <- BG_ck$freq*(0.5/xx)
                } 
        }
        
        df_Nx_P<- rbind(QG_ck, TG_ck,BG_ck)
        if(is.null(df_Nx_P)) {
                word_find <- FALSE
                return (NULL)
        } else {
                df_Nx_P$NextPrediction <- lapply(df_Nx_P$terms, function(x) sub(".*\\b(\\w+)$", "\\1", x))
                df_Nx_P$NextPrediction<-unlist(df_Nx_P$NextPrediction)
                df_Nx_P<- df_Nx_P[,-c(1,2)]
                
                df_N_Wd<-df_Nx_P%>%group_by(NextPrediction)%>%summarize(sum(disc))
                colnames(df_N_Wd)<- c("Next_Word","Probability")
                df_N_Wd<- df_N_Wd[order(df_N_Wd$Probability, decreasing = TRUE),]
                xx<- data.frame(Next_Word = df_N_Wd$Next_Word[1:50], 
                                Probability = format(round(df_N_Wd$Probability[1:50]*100, 2), nsmall = 2))
                return(xx)
        }
        
        
} 


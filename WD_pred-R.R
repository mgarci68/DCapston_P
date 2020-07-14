library(quanteda) ; library(DT)
library(stringi)
library(data.table)
library(dplyr)
library(tm)




Wd_pred<- function(t_str) {
        t_str_split <- unlist(strsplit(Clean_TeSt(t_str),split=" "))
        t_str_length <- length(t_str_split)
        
        QuadGram_check<- NULL
        TriGram_check<- NULL
        BiGram_check<- NULL
        if (t_str_length >= 3)
        {
                t_str_check <- paste(t_str_split[(t_str_length-2):t_str_length], collapse=" ");
                QuadGram_check <- df_qg[grep(paste("^",t_str_check, sep = ""), df_qg$terms), ]
                if (length(QuadGram_check[, 1]) >= 1){ 
                        xx<- sum(QuadGram_check$freq)
                        QuadGram_check$disc <- QuadGram_check$freq*(0.5/xx)
                }
                t_str_check <- paste(t_str_split[(t_str_length-1):t_str_length], collapse=" ");
                TriGram_check <- df_tg[grep(paste("^",t_str_check, sep = ""), df_tg$terms), ]
                if (length(TriGram_check[, 1]) >= 1){ 
                        xx<- sum(TriGram_check$freq)
                        TriGram_check$disc <- TriGram_check$freq*(0.3/xx)
                } 
                BiGram_check <- df_bg[grep(paste("^",t_str_split[t_str_length], sep = ""), df_bg$terms), ]
                if (length(BiGram_check[, 1]) >= 1){ 
                        xx<- sum(BiGram_check$freq)
                        BiGram_check$disc <- BiGram_check$freq*(0.2/xx)
                } 
        }
        
        if (t_str_length == 2)
        {
                t_str_check <- paste(t_str_split[(t_str_length-1):t_str_length], collapse=" ");
                TriGram_check <- df_tg[grep(paste("^",t_str_check, sep = ""), df_tg$terms), ]
                if (length(TriGram_check[, 1]) >= 1){ 
                        xx<- sum(TriGram_check$freq)
                        TriGram_check$disc <- TriGram_check$freq*(0.8/xx)
                } 
                BiGram_check <- df_bg[grep(paste("^",t_str_split[t_str_length], sep = ""), df_bg$terms), ]
                if (length(BiGram_check[, 1]) >= 1){ 
                        xx<- sum(BiGram_check$freq)
                        BiGram_check$disc <- BiGram_check$freq*(0.2/xx)
                } 
        }
        
        if (t_str_length == 1)
        {
                BiGram_check <- df_bg[grep(paste("^",t_str_split[t_str_length], sep = ""), df_bg$terms), ]
                if (length(BiGram_check[, 1]) >= 1){ 
                        xx<- sum(BiGram_check$freq)
                        BiGram_check$disc <- BiGram_check$freq*(0.5/xx)
                } 
        }
        
        DF_Next_Pred<- rbind(QuadGram_check, TriGram_check,BiGram_check)
        if(is.null(DF_Next_Pred)) {
                word_find <- FALSE
                return (NULL)
        } else {
                DF_Next_Pred$NextPrediction <- lapply(DF_Next_Pred$terms, function(x) sub(".*\\b(\\w+)$", "\\1", x))
                DF_Next_Pred$NextPrediction<-unlist(DF_Next_Pred$NextPrediction)
                DF_Next_Pred<- DF_Next_Pred[,-c(1,2)]
                
                DF_New_Word<-DF_Next_Pred%>%group_by(NextPrediction)%>%summarize(sum(disc))
                colnames(DF_New_Word)<- c("Next_Word","Probability")
                DF_New_Word<- DF_New_Word[order(DF_New_Word$Probability, decreasing = TRUE),]
                xx<- data.frame(Next_Word = DF_New_Word$Next_Word[1:50], 
                                Probability = format(round(DF_New_Word$Probability[1:50]*100, 2), nsmall = 2))
                return(xx)
        }
        
        
} 

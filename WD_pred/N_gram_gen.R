library(NLP);library(tm)
library(quanteda)
library(stringi)
library(data.table)
library(dplyr)
library(DT)
require(R.utils)
require(tm)
require(textcat)


mother_base<- getwd()
setwd("D:/Coursera/DataScience Spe/Capston Project/en_US")

con_news <- file("en_US.news.txt", open="r")
NW_tx <- readLines(con_news, n = -1L, ok = TRUE, encoding = "UTF-8", skipNul = FALSE)
tx_sl<- sample(1:length(NW_tx), size = length(NW_tx)/4, replace = F)
US_NW_tx <- NW_tx[tx_sl]
close(con_news); rm(NW_tx, tx_sl)

con_blogs <- file("en_US.blogs.txt", open="r")
bg_tx <- readLines(con_blogs, n = -1L, ok = TRUE, encoding = "UTF-8", skipNul = FALSE)
tx_sl<- sample(1:length(bg_tx), size = length(bg_tx)/4, replace = F)
US_bg_tx <- bg_tx[tx_sl]
close(con_blogs); rm(bg_tx, tx_sl)

con_tw <- file("en_US.twitter.txt", open="r")
tw_tx <- readLines(con_tw, n = -1L, ok = TRUE, skipNul = FALSE)
tx_sl<- sample(1:length(tw_tx), size = length(tw_tx)/4, replace = F)
US_tw_tx <- tw_tx[tx_sl]
close(con_tw); rm(tw_tx, tx_sl)

rm(con_news)
rm(con_blogs)
rm(con_tw)


ngram_gen<- function(dat10,i,j=3) {
        tidy_dt<- removePunctuation(dat10)
        tidy_dt<- stripWhitespace(tidy_dt)
        tidy_dt <- stri_trans_tolower(tidy_dt)
        tidy_dt1 <- gsub("ð|â|???|T|o|'|³|¾|ñ|f|.|º|°|»|²|¼|>|<|¹|·|¸|¦|~|ðÿ", "", tidy_dt) 
        
        
        #Remove single letter words
        tidy_dt1 <- removeWords(tidy_dt1, "\\b\\w{1}\\b")
        
        Dt_tk<- tokens(tidy_dt1,what ="word", remove_numbers = TRUE, 
                             remove_punct = TRUE, remove_separators = TRUE, remove_symbols =TRUE )
        
        Dt_gm <- tokens_ngrams(Dt_tk, n=i, concatenator = " ")  ## unigram
        Dt_gm_df <- dfm(Dt_gm, tolower =TRUE, remove_punct = TRUE)
        Dt_gm_df<- dfm_trim(Dt_gm_df, min_count = j, max_docfreq = 0.4)
        
         Dt_gm_mx <- sort(colSums(as.matrix(Dt_gm_df)),decreasing=TRUE)
         DataF_gm <- data.table(terms=names( Dt_gm_mx), freq= Dt_gm_mx)
        return ( DataF_gm)
}

NW_ug<-ngram_gen(US_NW_tx, 1,100)
NW_bg<-ngram_gen(US_NW_tx, 2,3)
NW_tg<-ngram_gen(US_NW_tx, 3,3)
NW_qg<-ngram_gen(US_NW_tx, 4,3)
gc()

Bg_ug<-ngram_gen(US_bg_tx, 1,100)
Bg_bg<-ngram_gen(US_bg_tx, 2,3)
Bg_tg<-ngram_gen(US_bg_tx, 3,3)
Bg_qg<-ngram_gen(US_bg_tx, 4,3)
gc()

Tw_ug<-ngram_gen(US_tw_tx, 1,100)
Tw_bg<-ngram_gen(US_tw_tx, 2,3)
Tw_tg<-ngram_gen(US_tw_tx, 3,3)
Tw_qg<-ngram_gen(US_tw_tx, 4,3)
gc()

df_ug<- rbind(NW_ug, Bg_ug,Tw_ug)
df_bg<- rbind(NW_bg, Bg_bg,Tw_bg)
df_tg<- rbind(NW_tg, Bg_tg,Tw_tg)
df_qg<- rbind(NW_qg, Bg_qg,Tw_qg)

df_ug<- df_ug[order(freq),]
df_bg<- df_bg[order(freq),]
df_tg<- df_tg[order(freq),]
df_qg<- df_qg[order(freq),]


rm(NW_ug, Bg_ug,Tw_ug)
rm(NW_bg, Bg_bg,Tw_bg)
rm(NW_tg, Bg_tg,Tw_tg)
rm(NW_qg, Bg_qg,Tw_qg)
rm(US_NW_tx,US_bg_tx,US_tw_tx)

setwd(mother_base)
save(df_ug, file="df_ug.RData");
save(df_bg, file="df_bg.RData");
save(df_tg, file="df_tg.RData");
save(df_qg, file="df_qg.RData")


load("df_ug.RData");
load("df_bg.RData");
load("df_tg.RData");
load("df_qg.RData")
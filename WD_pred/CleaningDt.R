Clean_TeSt <- function(i_string)
{
        i_string <- iconv(i_string, "latin1", "ASCII", sub=" ");
        i_string <- gsub("[^[:alpha:][:space:][:punct:]]", "", i_string);
        
        
        i_StCr <- VCorpus(VectorSource(i_string))
        
        
        i_StCr <- tm_map(i_StCr, content_transformer(tolower))
        i_StCr <- tm_map(i_StCr, removePunctuation)
        i_StCr <- tm_map(i_StCr, removeNumbers)
        i_StCr <- tm_map(i_StCr, stripWhitespace)
        i_string <- as.character(i_StCr[[1]])
        i_string <- gsub("(^[[:space:]]+|[[:space:]]+$)", "", i_string)
        
        
        if (nchar(i_string) > 0) {
                return(i_string); 
        } else {
                return("");
        }
}
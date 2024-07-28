# Install packages for text mining
install.packages(c("tm", "SnowballC", "wordcloud", "RColorBrewer"))

library(tm) # for text mining e.g. preprocessing, manipulating, analyzing textual data
library(SnowballC) # algorithms for stemming words => reduces words to their base or root form
library(wordcloud) # create visual representations of word frequency in text data
library(RColorBrewer)


setwd("C:/Users/USER/Desktop/혜원/SPRING 2024/EST 371")
# community leadership
community_leadership <- readLines("crawled data/community leadership. Kenya. Climate Change.txt")
head(community_leadership)


corpus <- Corpus(VectorSource(community_leadership))

corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, removeWords, stopwords("english"))

corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, stripWhitespace)

# Term-document matrix => describes the frequency of words in the documents
# TDM is a common representation in text mining and NLP for analyzing the content of textual data
tdm <- TermDocumentMatrix(corpus)
tdm
m <- as.matrix(tdm)
m # the matrix shows the word in row and the frequency of the word for each document.
# Since there are total 616 documents, it generates 616 columns
# Also, the terms are total 3649 (unique words)
word_freqs <- sort(rowSums(m), decreasing=TRUE)

top_5_freq <- names(head(word_freqs, 5))
word_freqs <- word_freqs[!names(word_freqs) %in% top_5_freq]

# wordcloud parameters
# 1. words : word vector
# 2. freq : frequency vector
# 3. min.freq : minimum frequency setting
# 4. scale : size setting for min and max frequently appearing words
# 5. colors : colors by frequency
# 6. random.orders : location (if FALSE, max frequency word is on the middle)
# 7. rot.per : rate for 90 degree


wordcloud(corpus, min.freq = 20, max.words = 100, random.order = FALSE, rot.per = 0.35, 
          colors = brewer.pal(8, "Dark2"))



# social cohesion
social_cohesion <- readLines("crawled data/social cohesion. Kenya. Climate Change.txt")
head(social_cohesion)

corpus <- Corpus(VectorSource(social_cohesion))

corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, removeWords, stopwords("english"))

corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, stripWhitespace)

wordcloud(corpus, min.freq = 20, max.words = 100, random.order = FALSE, rot.per = 0.35, 
          colors = brewer.pal(8, "Dark2"))

# youth engagement
youth_engagement <- readLines("crawled data/youth engagement. Kenya. Climate Change..txt")
head(youth_engagement)

# create a corpus
corpus <- Corpus(VectorSource(youth_engagement))
# convert the text to lower case
corpus <- tm_map(corpus, content_transformer(tolower))
# remove numbers
corpus <- tm_map(corpus, removeNumbers)
# remove common stopwords
corpus <- tm_map(corpus, removeWords, stopwords("english"))
# remove punctuation
corpus <- tm_map(corpus, removePunctuation)
# remove white spaces
corpus <- tm_map(corpus, stripWhitespace)

wordcloud(corpus, min.freq = 20, max.words = 100, random.order = FALSE, rot.per = 0.35, 
          colors = brewer.pal(8, "Dark2"))


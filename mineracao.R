###########################################################
# MINERAÇÃO DE TEXTO - CANAL DO YOUTUBE UNDER THE METAL
###########################################################

#Pacotes utilizados
pacotes <- c("tm","NLP", "quanteda","tidytext","ggplot2","dplyr","tibble","gutenbergr","wordcloud","stringr","SnowballC","widyr","janeaustenr")

if(sum(as.numeric(!pacotes %in% installed.packages())) != 0){
  instalador <- pacotes[!pacotes %in% installed.packages()]
  for(i in 1:length(instalador)) {
    install.packages(instalador, dependencies = T)
    break()}
  sapply(pacotes, require, character = T) 
} else {
  sapply(pacotes, require, character = T) 
}

# Carregando os pacotes/bibliotecas

library("dplyr")
library("tidytext")
library("ggplot2")
library("tibble")
library("wordcloud")
library("stringr")
library("SnowballC")


lista_1 <- c("Meus cinco vocalistas são: Warrel Danne, Ronnie James Dio, Geoff Tatte, Midnight",
"Na minha lista entrariam o Jon Oliva e o Ray Gillen",
"Meus: Steven Tyler, Sammy Haggar, Dio, John Busch, John Tardy",
"Realmente, num show a banda precisa interagir com o público, mas tem alguns que shows que são um espetáculo a parte! 
Então, se tiver os dois, melhor ainda! Ótima live!! Parabéns!!")

lista_2 <- "Esse é um dos meus quadros preferidos, 
realmente uma pena passar a ter um espaço tão longo de exibição!!!!!! Quanto as escolhas, conhecendo vcs acertei 90% mas o Camillo  ( cabeça de cotonete, kkkkkkkkk ) surpreendeu e muito como o Jack Star´s e o Diegão eu podia jurar que mandaria o Dokken em primeiro, hahahahaha!!!!!! Bem, a minha varia sempre, com exceção dos dois primeiros: hoje é essa...Judas Priest, Overkill, 
Grave Digger, Saxon e Ratt. Abraço meus irmãos!!!!!!"

lista_3 <- c("Não sabia que existe camiseta do burning star, eu curto muito o álbum rock the american way",
"Iron Maiden,  Savatage, Dream Theater,  Rainbow e Praying Mantis!",
"Mercyful fate, Slayer, Motorhead, Sodom, Bathory",
"Crimson Glory, Savage Grace, Vicious Rumors, Racer X, Icon")


comentario <- c(lista_1,lista_2,lista_3)

# Transformando em tibble

comentario_df <- tibble(line = 1:9,text = comentario)


# Transformando em token

df <- comentario_df %>% unnest_tokens(word,text)

# Pre - processamento

# Removendo os Stopwords

df <- df %>% anti_join(get_stopwords(language = 'pt'))

# Contar as palavras

df_count <- df %>% select(word) %>% count(word, sort = TRUE)

# Criar a word cloud

paleta_cores <- brewer.pal(12, "Paired")
df_count %>% with(wordcloud(word, n,random.order = FALSE,max.words = 50,colors=paleta_cores))


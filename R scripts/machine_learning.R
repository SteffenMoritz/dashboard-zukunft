require(randomForest)
require(caret)
library("missForest")

voegel4 <- as.data.frame(voegel4)
x <-voegel4[1:26,1:10]
x <- missForest(x)
x <- x$ximp
y <- as.numeric(voegel4[1:26,19])

rf <- train(x, y, 
            method = "rf",
            trControl = trainControl(method = "oob"),
            importance = TRUE,
            verbose = TRUE)

glm_data <- data.frame(x,y)

daten <- voegel4 %>% filter(Jahr >= 2010 & Jahr <= 2018)

xx <- glm(`Bestand repraesentativer Vogelarten, insgesamt` ~ 
            Umweltschutzausgaben_gesamt + 
             `Feinstaub (PM2,5)` + 
            `Anteil des Stroms aus erneuerbaren Energiequellen am Bruttostromverbrauch` + 
            Bevoelkerungsstand +
            `Bruttowertschoepfung in jeweiligen Preisen, insgesamt`,   data = daten)

summary(xx)

fm <- rf$finalModel


 varImp(fm)
 importance(fm)
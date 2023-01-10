ml_test <- function(predicted, true, output.as.table = FALSE){
  # testing for correct input
  predicted <- as.factor(predicted)
  true <- as.factor(true)
  if(!is.factor(predicted) | !is.factor(true)) stop(
    "Please make sure that both 'predicted' and 'true' could be converted
    into input of type 'factor' and retry."
  )
  if(length(predicted) != length(true)) stop(
    "Please make sure that both 'predicted' and 'true' are of the same length and retry."
  )
  if(!identical(levels(predicted), levels(true))) stop(
    "Please make sure that both 'predicted' and 'true' have identical factor-levels representing classes and retry."
  )
  if(!is.logical(output.as.table)) stop(
    "Please make sure that 'output.as.table' is either TRUE or FALSE and retry."
  )
  
  # creating a confusion matrix
  confusion_mtx <- table(predicted, true) # true classes are column-names
  rm(predicted, true)
  class_label_names <- rownames(confusion_mtx)
  
  # 'TP', 'FP' and 'FN' - 'True Positives', 'False Positives' and 'False Negatives'
  TP <- diag(confusion_mtx); FP <- rowSums(confusion_mtx)-TP; FN <- colSums(confusion_mtx)-TP
  # 'TN' - 'True Negatives'
  TN <- sapply(1:length(TP), function(y, TP){ sum(TP[-y], na.rm = TRUE) }, TP)
  
  # 'accuracy' = (TP+TN)/(TP+FP+TN+FN)
  accuracy <- sum(TP)/sum(confusion_mtx, na.rm = TRUE)
  rm(confusion_mtx)
  # 'recall' ('sensitivity', 'TPR') = TP/RP = TP/(TP+FN)
  precision <- TP/(TP+FP)
  # 'specificity' = TN/RN = TN/(TN+FP)
  recall <- TP/(TP+FN)
  # 'precision' ('PPV') = TP/PP = TP/(TP+FP)
  specificity <- TN/(TN+FP)
  names(specificity) <- class_label_names
  
  # 'Jaccard' = TP/(TP+FP+FN)
  Jaccard <- TP/(TP+FP+FN)
  
  # 'NPV' = TN/(TN+FN)
  NPV <- TN/(TN+FN)
  
  # 'MCC'
  MCC <- (TP*TN-FP*FN)/sqrt((TP+FP)*(TP+FN)*(TN+FP)*(TN+FN))
  rm(TP, TN, FP, FN)
  
  # 'balanced accuracy'
  balanced.accuracy <- (recall+specificity)/2
  # 'error.rate' = (FP+FN)/(TP+TN+FP+FN) = 1-accuracy
  error.rate <- 1-accuracy
  
  # 'F-scores' ('F.beta', where where beta is equal to 0.5, 1 or 2)
  F0.5 <- 1.25*(recall*precision/(0.25*precision+recall))
  F1 <- 2*(precision*recall/(precision+recall)) # Dice
  F2 <- 5*(precision*recall/(4*precision+recall))
  
  # 'FDR' = 1 - precision
  FDR <- 1-precision
  # 'FNR' = FN/(FN+TP) = 1 - recall
  FNR <- 1-recall
  # 'FOR' = 1 - NPV
  FOR <- 1-NPV
  # 'FPR' ('FAR') = FP/(FP+TN) = 1 - specificity
  FPR <- 1-specificity
  
  # 'geometric mean' (G)
  geometric.mean <- sqrt(recall*specificity)
  
  # 'L' ('LR(+)')
  L <- recall/(1-specificity)
  # 'lambda' ('LR(-)')
  lambda <- (1-recall)/specificity
  
  # 'DOR' = L/lambda = TP*TN/(FP*FN)
  DOR <- L/lambda
  
  # 'MK' = precision + NPV - 1
  MK <- precision + NPV - 1
  
  # 'OP' = accuracy - \recall-specificity\/(recall+specificity)
  OP <- accuracy - abs(recall-specificity)/(recall+specificity)
  
  # 'Youden's index'
  Youden <- recall+specificity-1
  
  # FINAL OUTPUT
  metrics_list <- list(accuracy = accuracy,
                       balanced.accuracy = balanced.accuracy,
                       DOR = DOR,
                       error.rate = error.rate,
                       F0.5 = F0.5,
                       F1 = F1,
                       F2 = F2,
                       FDR = FDR,
                       FNR = FNR,
                       FOR = FOR,
                       FPR = FPR,
                       geometric.mean = geometric.mean,
                       Jaccard = Jaccard,
                       L = L,
                       lambda = lambda,
                       MCC = MCC,
                       MK = MK,
                       NPV = NPV,
                       OP = OP,
                       precision = precision,
                       recall = recall,
                       specificity = specificity,
                       Youden = Youden)
  rm(balanced.accuracy, error.rate, F0.5, F1, F2, geometric.mean, L, lambda,
     MCC, recall, precision, specificity, Youden)
  if(output.as.table) return(as.data.frame(metrics_list, row.names = class_label_names)[,-c(1,4)])
  return(metrics_list)
}

# Read more on - https://rdrr.io/cran/mltest/man/ml_test.html

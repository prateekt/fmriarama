function wordCat = extractWordToCat()

%create map
wordCat = containers.Map('lolz','lolz');
remove(wordCat,'lolz');

%load data 
load data-science-P1.mat;

for i=1:length(info1)
    
    %extract current entry
    currentCat = info1(i).cond;
    currentWord = info1(i).word;
        
    %add (word,cat) to mapping
    if(~isKey(wordCat,currentWord))
        wordCat(currentWord) = currentCat;
    end
        
end
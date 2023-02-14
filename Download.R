
# Creates a list of identifiers for NCBI database
ncbi_ids <- c("HQ433692.1","HQ433694.1","HQ433691.1")

# Loads rentrez library
library(rentrez)  # you may need install.packages first

# Passed identifiers to NCBI database and receives data files in fasta format.
Bburg<-entrez_fetch(db = "nuccore", id = ncbi_ids, rettype = "fasta")

# View the Bburg object
print(Bburg)

# Creates new object containing one element for each sequence
Sequences=strsplit(Bburg, "\n\n")

# Check sequences were correctly seperated
print(Sequences)

# Convert Sequences to a non-list form
Sequences=unlist(Sequences)

# Separate sequences from headers
header<-gsub("(^>.*sequence)\\n[ATCG].*","\\1",Sequences)
print(header)
seq<-gsub("^>.*sequence\\n([ATCG].*)","\\1",Sequences)
print(seq)
Sequences<-data.frame(Name=header,Sequence=seq)
print(Sequences)

# Remove newline characters
Sequences$Sequence=gsub("[\\n|\n]","", Sequences$Sequence)
print(Sequences)

#Create csv file
write.csv(Sequences, file="Sequences.csv", row.names = F)

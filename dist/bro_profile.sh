export PATH=$PATH:/srv/bro/bin

# Function
bro-grep() { grep -E "(^#)|$1" $2; }
alias bro-column="sed \"s/fields.//;s/types.//\" | column -s $'\t' -t"

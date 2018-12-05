# In November-Decembe 2018 I ran a Secret Santa exchange for a subreddit. 
# With the exception of the Google Survey, everything was coded in R.
# Much of the code here is adjusted from that found elsewhere.
# I use random pseudo-data for obvious reasons. The random data mainain the structure of the original data.

# Load packages
library(dplyr)
# devtools::install_github("ropenscilabs/ponyexpress")
# ponyexpress is a mail-merge package
# See https://livefreeordichotomize.com/2017/11/15/secret-sampling/
library(ponyexpress)
# devtools::install_github("martineastwood/chancer")
# Chancer allows the generation of random words, names, addresses, etc. Great for this example.
library(chancer)

alldat <- data.frame(email = replicate(100, chancer.email()),
                     name = replicate(100, chancer.name()),
                     location = replicate(100, chancer.city()),
                     post = replicate(100, chancer.address()),
                     international = sample(c("Y", "N"), 100, replace = TRUE),
                     interests = replicate(100, gsub("^((\\w+\\W+){4}\\w+).*$","\\1", chancer.paragraph())), # First 5 words of a nonsense paragraph
                     other = replicate(100, paste("My favourite colour is", chancer.colour())),
                     support = replicate(100, chancer.domain()))

indat <- alldat %>% filter(international == "Y") # Only those willing to ship internationally
ukdat <- alldat %>% filter(international == "N") # Only those willing to ship within the UK

# make a Secret Santa function 
# adapted from https://www.r-bloggers.com/secret-santa-picker-2-using-r/
secret_santa <-function(names){
  
  # this 'flag' is used to determine if the
  # function stays in or out of the while function
  flag = "bad"
  
  npeople = length(names)
  
  # first list of names
  namelist1 = matrix(names, ncol = 1, nrow = npeople)
  fam = matrix(ncol = 1, nrow = npeople, NA)
  
  while (flag == "bad"){
    
    # names to choose from
    namelist2 = matrix(ncol = 1, nrow = npeople, NA)
    
    for (i in 1:npeople){
      #pick the first name
      if (i==1){
        xx2 = sample(names, (npeople-i+1), replace=FALSE)
      } else
        xx2 = sample(xx2, (npeople-i+1), replace=FALSE)
      
      if (i == npeople & xx2[1]==namelist1[i,1]){
        flag = "bad"
        
      }else if(xx2[1]!= namelist1[i,1]){
        namelist2[i,1] = xx2[1]
        flag = "good"
      } else{
        namelist2[i,1] = xx2[2]
        flag = "good"
      }
      
      
      #set up the new matrix with one less name
      used = which(xx2==namelist2[i])
      xx2[used] = "zzzzz"
      xx2 = sort(xx2)[1:(npeople-i)]
    }
    
    #flag
    
    #build the final matrices
    final <- cbind(namelist1, namelist2)	
    colnames(final) <- c("name", "partner")
    #the final results
    #final
    
    
  }
  as.data.frame(final)
}

### Function input
### make a list of names
in.names = as.character(indat$name) # Willing to ship internationally
uk.names = as.character(ukdat$name) # Only within the UK

#call the function
in.pairs <- secret_santa(in.names)
uk.pairs <- secret_santa(uk.names)

all.pairs <- rbind(in.pairs, uk.pairs) # Combine both outputs so that the final list contains all pairs

# Create reference dataframes for sender and partner and merge to output df
df_name <- alldat[ , c("name", "email")]
df_partner <- alldat[ , c("name", "post", "interests", "support", "other")]
dat <- all.pairs %>%
  left_join(df_name, c("name" = "name")) %>%
  left_join(df_partner, c("partner" = "name"))

# Create mail template for ponyexpress
template <- "Dear {name},

You have been assigned to surprise <b>{partner}</b> with an awesome gift! {partner} told us that they have the following interests:

<b>{interests}</b>

Here's the team(s) they support, should you want to send something along those lines:

<b>{support}</b>

They might have added some extra info, too. Don't blame me if there's nothing below, I'm coding the whole thing along the lines of a mail merge:

<b>{other}</b>

You should post your gift to:  

<b>{post}</b>

Remember the rules:
- Don't be a dick. This must operate on an honour code so don't send potentially inappropriate gifts.
- Absolutely NO EDIBLE GIFTS - this includes alcohol.
- Don't offer to send a gift to someone who wasn't matched or who didn't get a gift.
- No gift spoilers.
- I suggest a <b>general spending limit of £10 or equivalent</b>, not including postage. I can't enforce this, though, so it's up to you how much you spend. Just don't go too nuts, eh?
- Given the nature of the exchange, the mods can't be held accountable for anyone being a dick and the actual gifting will be entirely out of my hands.
- <b>Once you have posted your gift, send proof of postage via PM.</b>

Happy white elephant-ing,
Postal Elf"

parcel <- parcel_create(dat, # Create mail merge list
                        sender_name = "Postal Elf",
                        sender_email = "postal_elf@northpole.com",
                        subject = "/Secret Santa!",
                        template = template)


parcel_preview(parcel) # Preview output

parcel_send(parcel) # Send email from sender_email address

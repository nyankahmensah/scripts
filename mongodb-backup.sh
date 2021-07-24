# Create backup file
mongodump --uri="mongodb+srv://username:password@url.mongodb.net/database" --out="/Users/declan/Work/data/database"

# Restore backup file
mongorestore --uri="mongodb+srv://username:password@url.mongodb.net/database" --drop  /Users/declan/Work/data/database

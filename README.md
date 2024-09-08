# obviously_test_final

## Screen Descriptions

### Home Page - Tranaction Main View
- Loads and fetches transactions and balance from firebse
- Displays balance and transactions
- User can navigate to pay, topup and currency conversions
- User can drag down to refresh should they need to
- Shows cool wave animation in background

### Payment Screen 
- same code for both top up and make payment but changes flow based on button tapped
- Keyboard handles input errors such as starting with a leading 0 or trying to put >2 0s after decimal place
- Upon 'next' for make payment, navigate to 'who'. For top up, just show 'top up' button
- Shows confirmation screen for both transaction types, with conditional text for each case
- All transactions updated locally and via firebase
- Returns to home screen with updated activity

### Currency Converter 
- loads currency conversions in
- upon currency selected, show text input for desired GBP amount 


### Extra notes 
- I have added in a password screen with password 000000. This is a basic implementation that should be refactored with a FlowBuilder, such that the authentication does not rely on the password screen state. 
- I have added in firebase to handle the data and my API keys are still present in the project - this is okay for now as it is a small project and the firebase project is on the free plan. If this was a paid API key or project of business significance, I would put the firebase API key in a .env file and update the .gitignore to exlcude google-services.json and googleservice-info.plist from the git upload. 
# Registration

 This smart contract demonstrates a way to register users in the blockchain.  

## Roles

 1. Owner  
  The owner is the address publishing the smart contract. It can add and remove administrators.

 1. Administrator  
  The administrator can activate and deactivate a registered user.

 1. User  
  An user can register and unregister from the service.

## Contract description

### Public Variables

 - `active` = Active users
 - `register` = Registered users (active or not)

### Events 

 An event is fired for noticeable activity with the users.

  - `Registered`, `Unregistered` to notify each registration.
  - `Activated`, `Deactivated` to notify each activations.

### Public Methods

#### addMe()
 
 This will add the sender's address to the `register`

#### removeMe()

 This will remove the sender's address from the `register`

#### () (callback / sending money to the contract)

 This method will fail as it's content consists of `assert(false);`

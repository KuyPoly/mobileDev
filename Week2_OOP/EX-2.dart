class BankAccount {
    // TODO
    final int id;
    final String name;
    final String _cardNum;
    final String _phoneNumber;
    double _balance;

    // Getter
    String get cardNum => _cardNum;
    double get balance => _balance;
    String get phoneNumber => _phoneNumber;

    BankAccount(this.id, this.name, this._cardNum, this._phoneNumber, this._balance);

    // Methods
    void credit(double amount){
      assert(amount>0, 'Amount must be positive');
      _balance += amount;
    }
    
    void withdraw(double amount){
      assert(amount>0, 'Amount must be positive');
      if (_balance - amount < 0){
        throw Exception("Insufficiant balance!!!");
      } else {
        _balance -= amount;
      }
    }

}

class Bank {
    // TODO
    final String name;
    final Map<int, BankAccount> _account = {};

    Bank({required this.name});

    BankAccount createAccount(int accountId, String accountName, String accountNum, String accountPhoneNum, double accountBalance){
      if (_account.containsKey(accountId)){
        throw Exception("ID already exist, Please choose another ID");
      }else if(_account.values.any((acc) => acc.phoneNumber == accountPhoneNum)){
        throw Exception("Phone number already exist");
      }else {
        final account = BankAccount(accountId, accountName, accountNum, accountPhoneNum, accountBalance);
        _account[accountId] = account;
        return account;
      }
    }

}
 
void main() {

  Bank myBank = Bank(name: "CADT Bank");
  BankAccount ronanAccount = myBank.createAccount(100, 'Ronan', '123-456-789', '096123123', 0.0);

  print(ronanAccount.balance); // Balance: $0
  ronanAccount.credit(100);
  print(ronanAccount.balance); // Balance: $100
  ronanAccount.withdraw(50);
  print(ronanAccount.balance); // Balance: $50

  try {
    ronanAccount.withdraw(75); // This will throw an exception
  } catch (e) {
    print(e); // Output: Insufficient balance for withdrawal!
  }

  try {
    myBank.createAccount(100, 'Honlgy', '111-222-333', '0123123123',0.0); // This will throw an exception
  } catch (e) {
    print(e); // Output: ID already exist, Please choose another ID
  }

  try{
    myBank.createAccount(101, 'Poly', '111-123-123', '096123123', 0.2);
  } catch(error){
    print(error); // Output: Phone number already exist
  }
}
enum currency {USD, KHR}
enum accountType {SAVINGS, CHECKING, BUSINESS}

class InsufficientFundsException implements Exception {
  final String message;

  InsufficientFundsException(this.message);

  @override
  String toString() => 'InsufficientFundsException: $message';
}

class InvalidAmountException implements Exception {
  final String message;

  InvalidAmountException(this.message);

  @override
  String toString() => 'InvalidAmountException: $message';
}
class AccountAlreadyExistsException implements Exception {
  final String message;

  AccountAlreadyExistsException(this.message);

  @override
  String toString() => 'AccountAlreadyExistsException: $message';
}
class BankAccount {
  final String _accNumber;
  final String _accName;
  final accountType _accType;
  final currency _curr;
  double _balance = 0;

  BankAccount({
    required String accNumber,
    required String accName,
    required accountType accType,
    required currency curr,
  })  : _accNumber = accNumber,
        _accName = accName,
        _accType = accType,
        _curr = curr;
  
  String get accNumber => _accNumber;
  String get accName => _accName;
  accountType get accType => _accType;
  currency get curr => _curr;
  double get balance => _balance;

  void credit(double amount) {
    if (amount <= 0) {
      throw InvalidAmountException('Credit amount must be positive.');
    }
    _balance += amount;
    print('Credited: \$${amount.toStringAsFixed(2)}');
  }

  void withdraw(double amount) {
    if (amount <= 0) {
      throw InvalidAmountException('Withdrawal amount must be positive.');
    }
    if (amount > _balance) {
      throw InsufficientFundsException(
          'Attempted to withdraw \$${amount.toStringAsFixed(2)}, but only \$${_balance.toStringAsFixed(2)} is available.');
    }
    _balance -= amount;
    print('Withdrew: \$${amount.toStringAsFixed(2)}');
  }
}

class Bank {
  final String _name;
  final List<BankAccount> _accounts = [];
  double _totalAssets = 0;
  double _totalLoan = 0;
  double _interestRate = 0.05;

  Bank({required String name}): _name = name;

  String get name => _name;
  List<BankAccount> get accounts => _accounts; 
  double get totalAssets => _totalAssets;
  double get totalLoan => _totalLoan;
  double get interestRate => _interestRate;


  BankAccount createAccount(String accNumber, String accName, accountType accType, currency curr) {
    if (_accounts.any((account) => account.accNumber == accNumber)) {
      throw AccountAlreadyExistsException('Account number $accNumber already exists.');
    }

    var newAccount = BankAccount(accNumber: accNumber, accName: accName, accType: accType, curr: curr);
    _accounts.add(newAccount);

    _totalAssets += newAccount.balance;

    print('Account number $accNumber named $accName added successfully.');

    return newAccount;
  }

}

void main() {
  Bank myBank = Bank(name: "CADT Bank");
  BankAccount ronanAccount = myBank.createAccount('100', 'Ronan', accountType.SAVINGS, currency.USD);

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
    myBank.createAccount('100', 'Honlgy', accountType.BUSINESS, currency.KHR); // This will throw an exception
   } catch (e) {
    print(e); // Output: Account with ID 100 already exists!
  }
}

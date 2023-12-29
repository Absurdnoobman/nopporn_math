import 'package:nopporn_math/nopporn_math.dart' as nopporn;
import 'dart:io';

void main(List<String> arguments) {
    int? opt;
	print("Hello, Welcome");
	while (true) {
		opt = inputInt(""" 
Enter the following option:
			0: exit
			1: basic Arithmetic
			2: Nopporn's Statistics
			3: Area
				""");

		switch (opt) {
		case 0:
			print("Exiting");
			exit(0);
		case 1:
			basicArith();
			break;
		case 2:
			noppornStat();
			break;
		case 3:
			area();
			break;
		default:
			print("$opt is not within the option");
			break;
		}
	}
}

void addition() {
	num a, b;
	a = inputNumber("Enter the first number");
	b = inputNumber("Enter the second number");
	num c;
	try {
		c = nopporn.BasicArithmetic.add(a, b);
	} catch (e) {
		print("Error: $e");
		return;
	}
	print("The result is $c");
}

void remove() {
	num a, b;
	a = inputNumber("Enter the first number");
	b = inputNumber("Enter the second number");
	num c;
	try {
		c = nopporn.BasicArithmetic.remove(a, b);
	} catch (e) {
		print("Error: $e");
		return;
	}
	print("The result is $c");
}

void findAvr() {
	List<num> inputList = inputListNumber("Enter the element");
	num result = nopporn.NoppornStatistics.average(inputList);
	print("The result is $result");
}

void findMed() {
	List<num> inputList = inputListNumber("Enter the element");
	num result = nopporn.NoppornStatistics.median(inputList);
	print("The result is $result");
}

void findMod() {
	List<num> inputList = inputListNumber("Enter the element");
	num? result = nopporn.NoppornStatistics.mod(inputList);
	if (result == null) {
		print("There is no mod in this list");
		return;
	}
	print("The result is $result");
}

void noppornMode(){
	List<num> data = inputListNumber("Enter the element");
    data.sort();
    Map<String, num?> result = {};
	result['avr'] = nopporn.NoppornStatistics.average(data);
    result['med'] = nopporn.NoppornStatistics.median(data);
    result['mod'] = nopporn.NoppornStatistics.mod(data);
    bool ans = yesOrNo("Is Q D P require?");
    if(ans){
        
        return;
    } else {
        print("""
data : $data 
average : ${result['avr']}
median : ${result['med']}
mod : ${result['mod']}
        """);
        return;
    }
}

void findAreaCircle() {
	num r = inputNumber("What is the radius? (if the given radius is negative, radius will be converted to postive automatically)");
	num result;
	try {
		result = nopporn.Area.circleArea(r.abs());
	} catch (e) {
		print("Error: $e");
		return;
	}
	print( r.isNegative ? 
        "The result is $result (WARNNING: The Given radius has been coverted from Negative '$r' to Positive '${r.abs()}' )" : "The result is $result" 
    );
}

List<num> inputListNumber(String msg) {
	List<num> data = [];
	while (true) {
		print(msg);
		print("Enter any character to terminate");
		String? value = stdin.readLineSync();
		if (value == null || value == "") {
		print("Unexpected empty String");
		continue;
		} else {
		num? result = num.tryParse(value);
		if (result == null) {
			if (data.isEmpty) {
			print("List can not be empty");
			continue;
			} else {
			break;
			}
		} else {
			data.add(result);
			continue;
		}
		}
	}
	return data;
}

num inputNumber(String msg) {
	num? result;
	while (true) {
		print(msg);
		String? value = stdin.readLineSync();
		if (value == null) {
		print("Please enter number");
		} else {
		try {
			result = num.parse(value);
		} on FormatException {
			print("Error: FormatException: Not a number");
			continue;
		} catch (e) {
			print("Error: $e");
			continue;
		}
		break;
		}
	}
	return result;
}

int inputInt(String msg) {
	int? result;
	while (true) {
		print(msg);
		String? value = stdin.readLineSync();
		if (value == null) {
		print("Please enter number integer");
		} else {
		try {
			result = int.parse(value);
		} on FormatException {
			print("Error: FormatException: Not a Integer");
			continue;
		} catch (e) {
			print("Error: $e");
			continue;
		}
		break;
		}
	}
	return result;
}

bool yesOrNo(String msg){
    while(true){
        print(msg);
        print('Yes Or No (y/n) :');
        String? value = stdin.readLineSync();
        if(value == null){
            print("Unexpected empty string");
            continue;
        } else {
            switch(value){
                case "Yes"|| "yes" || 'y' || 'Y' || 'yep' || 'Yep' || "YES" :
                    return true;
                case "No" || "no" || 'n' || 'N' || 'nop' || 'Nop' || 'NO' :
                    return false;
                default:
                    print("Enter 'y' for affirmative or n for'negative'");
                    continue;
            }
        }
    }
}

void basicArith() {
	while (true) {
		int opt = inputInt("""
Enter the following option:
			0: Back
			1: addition
			2: subtraction
			""");
		switch (opt) {
		case 0:
			return;
		case 1:
			addition();
			break;
		case 2:
			remove();
			break;
		default:
			print("$opt is not within the option");
			continue;
		}
	}
}

void noppornStat() {
	while (true) {
		int opt = inputInt("""
Enter the following option:
			0  : Back
			1  : average arithmetic
			2  : median
	  		3  : mod
			69 : 'Nopporn' mode
		""");
		switch (opt) {
		case 0:
			return;
		case 1:
			findAvr();
			break;
		case 2:
			findMed();
			break;
		case 3:
			findMod();
			break;

		case 69: // Nice
			noppornMode();
			break;

		
		default:
			print("$opt is not within the option");
			continue;
		}
	}
}

void area() {
	while (true) {
		int opt = inputInt("""
Enter the following option:
			0: Back
			1: Circle
			2: Rectangle or Square
		""");
		switch (opt) {
		case 0:
			return;
		case 1:
			findAreaCircle();
			break;
		}
 	}
}

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
    bool qdrNeeded = yesOrNo("Is Q D P require?");
    if(qdrNeeded){
        print(
            """
    Please enter the quadtile(Qr) or dectile(Dr) or percentile(Pr) in the following format:

    for Quadtile => Q_n ; n is the position of quadtile or nth Quadtile and 0 < n <= 4 must be true or meaning n must be greater than 0 and less than 5 EX. Q_4 mean 4th Quadtile
    for Dectile => D_n; n is the position of dectile or nth dectile and 0 < n <= 10 must be true or meaning n must be greater than 0 and less than 11 EX. D_6 mean 6th Dectile
    for percentile => P_n; n is the position of percentile or nth percentile and 0 < n <= 100 must be true or meaning n must be greater than 0 and less than 101 EX. P_69 mean 69th Percentile

    Can enter multiple value.
    Ex. Q_2 P_45 D_3 Q_3 
            """
        );
        while(true){
            List<String> input = inputListStr(
                "Enter the data:", 
                ' '
            );
        
            Map<String, int> dataQDP = {};
            for(String element in input){
                List<String> seperated = element.split('_');
                if( !(RegExp(r'[QDP]').hasMatch(seperated[0])) ){
                    print("${seperated[0]} is invalid format");
                    break;
                }
                if( !(RegExp(r'\d+').hasMatch(seperated[1])) ){
                    print("${seperated[1]} is invalid format");
                    break;
                } else {
                    int? n = int.tryParse(seperated[1]);
                    if(n == null){
                        print("Can not covert '${seperated[1]}' to integer");
                        break;
                    } else {
                        switch(seperated[0]){
                            case 'Q':
                                if(0 < n && n < 5){
                                    dataQDP[seperated[0]] = n;
                                    continue;
                                } else {
                                    print("n must be  within 1 to 4");
                                    break;
                                }
                            case 'D':
                                if(0 < n && n < 11){
                                    dataQDP[seperated[0]] = n;
                                    continue;
                                } else {
                                    print("n must be  within 1 to 10");
                                    break;
                                }
                            case 'P':
                                if(0 < n && n < 101){
                                    dataQDP[seperated[0]] = n;
                                    continue;
                                } else {
                                    print("n must be  within 1 to 100");
                                    break;
                                }
                            default:
                                print("${seperated[0]} is invalid format");
                                break;
                        }
                    }
                }
            }
        }
        
        
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

List<String> inputListStr(String msg, String sprBy) {
	List<String> data = [];
	while (true) {
		print(msg);
        print("Each element is seperated by '$sprBy'");
		print("Press 'Enter' to comfirm");
		String? value = stdin.readLineSync();
		if (value == null || value == "") {
            print("Unexpected empty String");
            continue;
		} else {
            try {
                data = value.split(sprBy);
            } catch (e) {
                rethrow;
            }
            break;
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
            print("Enter 'y' for affirmative or n for'negative'");
            continue;
        } else {
            switch(value){
                case "Yes"|| "yes" || 'y' || 'Y' || 'yep' || 'Yep' || "YES" || "Aye":
                    return true;
                case "No" || "no" || 'n' || 'N' || 'nop' || 'Nop' || 'NO' || "Fuck it":
                    return false;
                case "Fuck" || "fuck":
                    print("Unexpected reproduction!!! T_T");
                    print("Enter 'y' for affirmative or n for'negative'");
                    continue;
                default:
                    print("Unexpected $value");
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

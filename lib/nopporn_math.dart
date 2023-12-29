import 'dart:math';

/* This is class*/
class NoppornMath {}

class BasicArithmetic extends NoppornMath {
    static num add(num x, num y) {
        if (x + y > double.maxFinite) {
            throw Exception("OverflowError");
        }
        return x + y;
    }

    static num remove(num x, num y) {
        return x - y;
    }
}

class NoppornStatistics extends NoppornMath {
    static num average(List<num> list) {
        num sum = 0;
        int numberOfElements = 0;
        for (num element in list) {
            sum += element;
        }
        numberOfElements = list.length;
        num result = sum / numberOfElements;
        return result;
    }

    static num median(List<num> list) {
        list.sort();
        num medianIndex =
            (list.length + 1) / 2; 
    /*
    [1, 2, 3] [0] [1] [2]
    according to formula 3 + 1 / 2 = 2
    so index need to be [2 - 1] = [1]
    */
        if (!(list.length.isOdd)) {
            int lowerBound = medianIndex.floor() - 1;
            int upperBound = medianIndex.ceil()  - 1;
            return (list[lowerBound] + list[upperBound]) / 2;
        } else {
            int index = medianIndex.toInt();
            return list[index - 1];
        }
    }

    static num? mod(List<num> list){
        list.sort();
        List<num> repeatNum = [];
        List<num> otherNum = [];
        num? mod ;
        for(num element in list ) {
            if (otherNum.contains(element)){
                repeatNum.add(element);
            } else {
                otherNum.add(element);
            }
        }
        if(repeatNum.length > 1 || repeatNum.isEmpty){
            return mod;
        } else {
            mod = repeatNum[0];
        }
        return mod;
    }
}

class Area extends NoppornMath{
    static circleArea(num radius){
        num area;
        try{
            area = radius * radius * pi;
        }
        catch (e){
           rethrow;
        }
        return area;
    }
    static circleCircum(num radius){
        num circum;
        try{
            circum = 2 * radius * pi;
        }
        catch (e){
            rethrow;
        }
        return circum;
    }
}
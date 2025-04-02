#include <iostream>
#include <string>

using namespace std;

class RecursiveDescentParser {
    string input;
    int pos;

public:
    RecursiveDescentParser(string str) : input(str), pos(0) {}

    bool S() {
        if (match('a')) {
            return true;
        }
        if (match('(')) {
            if (L() && match(')')) {
                return true;
            }
        }
        return false;
    }

    bool L() {
        if (S()) {
            return LPrime();
        }
        return false;
    }

    bool LPrime() {
        if (match(',')) {
            if (S()) {
                return LPrime();
            }
            return false;
        }
        return true; // ε transition
    }

    bool match(char expected) {
        if (pos < input.length() && input[pos] == expected) {
            pos++;
            return true;
        }
        return false;
    }

    bool parse() {
        return S() && pos == input.length();
    }
};

int main() {
    string testCases[] = {"a", "(a)", "(a,a)", "(a,(a,a))", "(a,a),(a,a)", "a)", "(a", "a,a", "(a,a),a"};

    for (string test : testCases) {
        RecursiveDescentParser parser(test);
        if (parser.parse()) {
            cout << test << " -> Valid string" << endl;
        } else {
            cout << test << " -> Invalid string" << endl;
        }
    }

    return 0;
}

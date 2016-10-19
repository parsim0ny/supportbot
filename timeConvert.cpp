#include <iostream>
#include <cstdlib>
#include <fstream>

using namespace std;

int main()
{
    int day;
    int hour;
    ifstream inFile;
    inFile.open("time.txt");

    inFile >> day >> hour;

    if ((day >= 1) && (day <= 5)) {
        if ((hour >= 8) && (hour < 18)) {
            cout << "Thank you for contacting CAT Support. Someone should be with you shortly. " <<
                    "If you do not hear from us within a few minutes, try emailing support@cat.pdx.edu " <<
                    "or calling us at (503) 725-5420.";
        }
        else {
            cout << "Thank you for contacting CAT Support. Our normal operating hours are Mon-Fri 8:00am-6:00pm and Sat 12:00pm-5:00pm. " <<
                    "If nobody is available to help you here, the best way to reach us is by emailing support@cat.pdx.edu.";
        }
    }
    else if (day == 6) {
        if ((hour >= 12) && (hour < 17)) {
            cout << "Thank you for contacting CAT Support. Someone should be with you shortly. " <<
                    "If you do not hear from us within a few minutes, try emailing support@cat.pdx.edu " <<
                    "or calling us at (503) 725-5420.";
        }
        else {
            cout << "Thank you for contacting CAT Support. Our normal operating hours are Mon-Fri 8:00am-6:00pm and Sat 12:00pm-5:00pm. " <<
                    "If nobody is available to help you here, the best way to reach us is by emailing support@cat.pdx.edu.";
        }
    }
    else {
        cout << "Thank you for contacting CAT Support. Our normal operating hours are Mon-Fri 8:00am-6:00pm and Sat 12:00pm-5:00pm. " <<
                "If nobody is available to help you here, the best way to reach us is by emailing support@cat.pdx.edu.";
    }

    inFile.close();
    return 0;
}


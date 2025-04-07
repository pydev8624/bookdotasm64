#include <iostream>

using namespace std;

int main()
{
    int c=10;
    while (c<10)
    {
        cout<<"while "<<c<<endl;
        c++;
    }
    c=10;
    do
    {
        cout<<"do..while "<<c<<endl;
        c++;
    }
    while(c<10);
    return 0;
}

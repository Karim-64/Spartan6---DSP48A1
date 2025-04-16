#include<iostream>
using namespace std;
int main()
{
    int x = 3968;
    int y = 73; 
    int cin = 0;
    long long result1;
    long long result2;
    result1 = y-x-cin;
    result1 &= 0xFFFFFFFFFFFF;
    result2 &= y-x-cin;
    result2 &= 0x1000000000000;
    cout<<result1<<" "<<result2;
}
/**
*Created by Arkadiusz Kraus
**/
#include<iostream>
#include<ctime>
#include<cstdlib>
#include<fstream>
#include<string>
#include<makeIn.cpp>
#define loop(i,j,s) for(int i=j;i<s;i++)
using namespace std;
fstream in;
string nameOfProgram;
int numberOfTests;

string intToStr(int a){
	string ans="";
	while(a>0){
		ans=char(a%10+'0')+ans;
		a=a/10;
	}
	return ans;
}

void generateIns(){
	string file;
	loop(i,1,numberOfTests+1){
		file=nameOfProgram+"/in/"+nameOfProgram;
		if(i<=9)
			file=file+char(i+'0');
		else
			file=file+intToStr(i);
		file=file+".in";
		cout<<file<<"\n";		
		in.open(file.c_str(),std::ios::out);
		makeIn(i,&in);
		in.close();
	}
}
int main(){
	cin>>nameOfProgram>>numberOfTests;
	srand(time(NULL));
	generateIns();
}

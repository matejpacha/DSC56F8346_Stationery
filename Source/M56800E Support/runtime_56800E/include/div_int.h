int ARTDIVS16UZ(int,int);
int ARTDIVU16UZ(int,int);
int F_idiv_ls_canoverflow(int,long);
int F_idiv_uls_canoverflow(int,long);

long long ARTADDLL64(long long, long long);
long long ARTSUBLL64(long long, long long);
long long ARTNEGLL64(long long);
long long ARTMULLL64(long long, long long);
long long ARTMULULL64(long long,long long);

long long ARTMULFLL64(long long,long long);

long long ARTDIVLL64(long long, long long);	// long long division
long long ARTDIVULL64(long long, long long); // unsigned long long divion

long ARTDIV64(long long, long);  // long long fractional division

/*56800EX instructions intrinsic functions support*/
long long V3ARTIMPY64(long, long);
long long V3ARTMPY64(long, long);

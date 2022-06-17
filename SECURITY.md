Hi sreeram-katraparthi,

I am Enoch from the Roche security team.
We recently discovered that you have hosted a file that contain credentials with our organization. 

https://github.com/sreeram-katraparthi/DemoOrg_RemoteRepository/blob/02d4fc3924674046cfcc19c5bdb96b7642a9f627/force-app/main/default/classes/BasicAuthentication.cls

Could we check what is the purpose of the credentials?

string username = 'sfmcsfdcuser@roche.com.pt13';
string password = 'roche#1234';
string url = 'https://sfdc-sfmc-auth.com';
//string url = 'https://sfdc-sfmc-auth.com?grant_type=client_credentials&client_id=3MVG92u_V3UMpV.g266PNI7t8sUciOoP_ivxwuZ2vWtCr1KyVt_mZpa3Ut9z10PMaTLSaubZQzM8swrnhxcXC&client_secret='+
// '8703768126036164056&username=sfmcsfdcuser@roche.com.pt13&password=roche#1234';

Please contact us on vulnerability.management@roche.com.

Thanks and regards,
Enoch

/*MaterialApp(
debugShowCheckedModeBanner: false,
title: 'Flutter Demo',
theme: ThemeData(
primarySwatch: Colors.teal,
),
home: Builder(builder: (context) {
return Container(
color: Color(0xFFBDDBB1),
child: Column(
crossAxisAlignment: CrossAxisAlignment.center,
mainAxisAlignment: MainAxisAlignment.center,
children: [
Image.asset('assets/images/page1_image-01.png')
,DefaultTextStyle(
style: TextStyle(fontSize: 48,fontWeight: FontWeight.bold, color: Colors.teal),
child: AnimatedTextKit(animatedTexts: [
RotateAnimatedText("Merhaba",rotateOut: false),
]),
),
TextButton(
onPressed: () async {
bool visitingFlag = await getvisitingFlag();
setVisitingFlag();
if (visitingFlag == true) {
Navigator.of(context).push(
MaterialPageRoute(builder: (context) => homePage()));
} else {
Navigator.of(context).push(MaterialPageRoute(
builder: (context) => onboardingScreen()));
}
},
child: Text(
'Giriş',
style: TextStyle(color: Colors.teal, fontSize: 32),
))
],
),
);
}),
);


ElevatedButton(onPressed: (){
            final user = userModel(userNameController.text, apartmentNoController.text);
            widget.addUser(user);
          }, child: Text("ekle"))







ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(4),
                  child: ListTile(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => allExpensesScreen()));
                    },
                    title: Text(userList[index].userName),
                    subtitle: Text(userList[index].apartmentNo),
                  ),
                );
              },
              itemCount: userList.length)
*/
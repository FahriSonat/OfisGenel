1. widget tree 
*iskelet
*imutable(değişmez)
*çok ucuz(hafif)
*saniyede 60-120 kez çöpe atılıp yeniden üretilir
*ekranda çizim yapmaz
*sadece şablon sunar


2. element tree 
*yönetici & yaşayan omurga
*mutable (durumu ve referansı hafızada canlı tutar değişir)
*widget ile renderobject arasındaki koordinatlarıdır(organizasyonu sunar)

static bool canUpdate(widget oldwidget, widget newWidget){
    return oldwidget.runtimeType=newWidget.runtimeType && oldWidget.
    key==newWidget.key;
}

State Yaşam Döngüsü 

*StatefulWidget immutable (olarak değişmez) her rebuild'de yeniden oluşturulur

*State mutable (durumu saklar) rebuild sırasında çöpe atılmaz element tarafında devam eder

eğer iki sınıf birleşik olsaydı her rebuild esnasında kullanıcı



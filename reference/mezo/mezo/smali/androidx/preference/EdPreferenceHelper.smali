# classes10.dex

.class public Landroidx/preference/EdPreferenceHelper;
.super Ljava/lang/Object;
.source "EdPreferenceHelper.java"


# static fields
.field public static final TAG:Ljava/lang/String; = "ED_PREFS "


# instance fields
.field private final AUTHOR:Ljava/lang/String;

.field private BUILD_VER:Ljava/lang/String;

.field private final attrs:Landroid/util/AttributeSet;

.field private final contentResolver:Landroid/content/ContentResolver;

.field private final context:Landroid/content/Context;


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;Landroid/content/ContentResolver;Ljava/lang/String;)V
    .registers 6

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "Patched by @HassanMirza01"

    iput-object v0, p0, Landroidx/preference/EdPreferenceHelper;->AUTHOR:Ljava/lang/String;

    iput-object p1, p0, Landroidx/preference/EdPreferenceHelper;->context:Landroid/content/Context;

    iput-object p2, p0, Landroidx/preference/EdPreferenceHelper;->attrs:Landroid/util/AttributeSet;

    iput-object p3, p0, Landroidx/preference/EdPreferenceHelper;->contentResolver:Landroid/content/ContentResolver;

    iput-object p4, p0, Landroidx/preference/EdPreferenceHelper;->BUILD_VER:Ljava/lang/String;

    return-void
.end method

.method private getResourceId(Ljava/lang/String;Ljava/lang/String;)I
    .registers 5

    iget-object v0, p0, Landroidx/preference/EdPreferenceHelper;->context:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    iget-object v1, p0, Landroidx/preference/EdPreferenceHelper;->context:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, p1, p2, v1}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    return v0
.end method


# virtual methods
.method protected getArrayFromAttr(Ljava/lang/String;Ljava/lang/String;)[Ljava/lang/String;
    .registers 8

    iget-object v0, p0, Landroidx/preference/EdPreferenceHelper;->attrs:Landroid/util/AttributeSet;

    invoke-interface {v0, p1, p2}, Landroid/util/AttributeSet;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    if-eqz v0, :cond_46

    const-string v2, "@"

    invoke-virtual {v0, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_3f

    const/4 v2, 0x1

    :try_start_12
    invoke-virtual {v0, v2}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v2

    iget-object v3, p0, Landroidx/preference/EdPreferenceHelper;->context:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    invoke-virtual {v3, v2}, Landroid/content/res/Resources;->getStringArray(I)[Ljava/lang/String;

    move-result-object v1
    :try_end_24
    .catch Landroid/content/res/Resources$NotFoundException; {:try_start_12 .. :try_end_24} :catch_25
    .catch Ljava/lang/NumberFormatException; {:try_start_12 .. :try_end_24} :catch_25

    return-object v1

    :catch_25
    move-exception v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Invalid resource reference for array: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const-string v4, "ED_PREFS "

    invoke-static {v4, v3, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    return-object v1

    :cond_3f
    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v1

    return-object v1

    :cond_46
    return-object v1
.end method

.method public getBool(Ljava/lang/String;ZI)Z
    .registers 6

    invoke-virtual {p0, p1, p2, p3}, Landroidx/preference/EdPreferenceHelper;->getInt(Ljava/lang/String;II)I

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_8

    goto :goto_9

    :cond_8
    const/4 v1, 0x0

    :goto_9
    return v1
.end method

.method protected getBooleanFromAttr(Ljava/lang/String;Ljava/lang/String;Z)Z
    .registers 5

    iget-object v0, p0, Landroidx/preference/EdPreferenceHelper;->attrs:Landroid/util/AttributeSet;

    invoke-interface {v0, p1, p2, p3}, Landroid/util/AttributeSet;->getAttributeBooleanValue(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v0

    return v0
.end method

.method public getColor(Ljava/lang/String;)I
    .registers 3

    const-string v0, "color"

    invoke-direct {p0, p1, v0}, Landroidx/preference/EdPreferenceHelper;->getResourceId(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public getDrawable(Ljava/lang/String;)I
    .registers 3

    const-string v0, "drawable"

    invoke-direct {p0, p1, v0}, Landroidx/preference/EdPreferenceHelper;->getResourceId(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public getId(Ljava/lang/String;)I
    .registers 3

    const-string v0, "id"

    invoke-direct {p0, p1, v0}, Landroidx/preference/EdPreferenceHelper;->getResourceId(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public getInt(Ljava/lang/String;II)I
    .registers 5

    packed-switch p3, :pswitch_data_18

    iget-object v0, p0, Landroidx/preference/EdPreferenceHelper;->contentResolver:Landroid/content/ContentResolver;

    invoke-static {v0, p1, p2}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v0

    return v0

    :pswitch_a  #0x2
    iget-object v0, p0, Landroidx/preference/EdPreferenceHelper;->contentResolver:Landroid/content/ContentResolver;

    invoke-static {v0, p1, p2}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v0

    return v0

    :pswitch_11  #0x1
    iget-object v0, p0, Landroidx/preference/EdPreferenceHelper;->contentResolver:Landroid/content/ContentResolver;

    invoke-static {v0, p1, p2}, Landroid/provider/Settings$Secure;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v0

    return v0

    :pswitch_data_18
    .packed-switch 0x1
        :pswitch_11  #00000001
        :pswitch_a  #00000002
    .end packed-switch
.end method

.method protected getIntFromAttr(Ljava/lang/String;Ljava/lang/String;I)I
    .registers 5

    iget-object v0, p0, Landroidx/preference/EdPreferenceHelper;->attrs:Landroid/util/AttributeSet;

    invoke-interface {v0, p1, p2, p3}, Landroid/util/AttributeSet;->getAttributeIntValue(Ljava/lang/String;Ljava/lang/String;I)I

    move-result v0

    return v0
.end method

.method public getLayout(Ljava/lang/String;)I
    .registers 3

    const-string v0, "layout"

    invoke-direct {p0, p1, v0}, Landroidx/preference/EdPreferenceHelper;->getResourceId(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method protected getPropBoolean(Ljava/lang/String;Z)Z
    .registers 5

    :try_start_0
    invoke-static {p1, p2}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_4} :catch_5

    return v0

    :catch_5
    move-exception v0

    const-string v1, "Target Prop isn\'t read-able"

    invoke-virtual {p0, v1}, Landroidx/preference/EdPreferenceHelper;->showToast(Ljava/lang/String;)V

    const/4 v0, 0x0

    return v0
.end method

.method protected getPropString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .registers 5

    :try_start_0
    invoke-static {p1, p2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_4} :catch_5

    return-object v0

    :catch_5
    move-exception v0

    const-string v1, "Target Prop isn\'t read-able"

    invoke-virtual {p0, v1}, Landroidx/preference/EdPreferenceHelper;->showToast(Ljava/lang/String;)V

    const/4 v0, 0x0

    return-object v0
.end method

.method public getString(Ljava/lang/String;Ljava/lang/String;I)Ljava/lang/String;
    .registers 6

    packed-switch p3, :pswitch_data_1e

    iget-object v0, p0, Landroidx/preference/EdPreferenceHelper;->contentResolver:Landroid/content/ContentResolver;

    invoke-static {v0, p1}, Landroid/provider/Settings$System;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_18

    :pswitch_a  #0x2
    iget-object v0, p0, Landroidx/preference/EdPreferenceHelper;->contentResolver:Landroid/content/ContentResolver;

    invoke-static {v0, p1}, Landroid/provider/Settings$Global;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_18

    :pswitch_11  #0x1
    iget-object v0, p0, Landroidx/preference/EdPreferenceHelper;->contentResolver:Landroid/content/ContentResolver;

    invoke-static {v0, p1}, Landroid/provider/Settings$Secure;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    nop

    :goto_18
    if-eqz v0, :cond_1c

    move-object v1, v0

    goto :goto_1d

    :cond_1c
    move-object v1, p2

    :goto_1d
    return-object v1

    :pswitch_data_1e
    .packed-switch 0x1
        :pswitch_11  #00000001
        :pswitch_a  #00000002
    .end packed-switch
.end method

.method protected getStringFromAttr(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .registers 7

    iget-object v0, p0, Landroidx/preference/EdPreferenceHelper;->attrs:Landroid/util/AttributeSet;

    invoke-interface {v0, p1, p2}, Landroid/util/AttributeSet;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_26

    const-string v1, "@"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_26

    const/4 v1, 0x1

    :try_start_11
    invoke-virtual {v0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v1

    iget-object v2, p0, Landroidx/preference/EdPreferenceHelper;->context:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    invoke-virtual {v2, v1}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v2
    :try_end_23
    .catch Landroid/content/res/Resources$NotFoundException; {:try_start_11 .. :try_end_23} :catch_24
    .catch Ljava/lang/NumberFormatException; {:try_start_11 .. :try_end_23} :catch_24

    return-object v2

    :catch_24
    move-exception v1

    return-object p3

    :cond_26
    return-object v0
.end method

.method public putBool(Ljava/lang/String;ZI)V
    .registers 4

    invoke-virtual {p0, p1, p2, p3}, Landroidx/preference/EdPreferenceHelper;->putInt(Ljava/lang/String;II)V

    return-void
.end method

.method public putInt(Ljava/lang/String;II)V
    .registers 6

    packed-switch p3, :pswitch_data_32

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "ED_PREFS "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Landroidx/preference/EdPreferenceHelper;->BUILD_VER:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "Invalid type for putInt"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_30

    :pswitch_1e  #0x2
    iget-object v0, p0, Landroidx/preference/EdPreferenceHelper;->contentResolver:Landroid/content/ContentResolver;

    invoke-static {v0, p1, p2}, Landroid/provider/Settings$Global;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    goto :goto_30

    :pswitch_24  #0x1
    iget-object v0, p0, Landroidx/preference/EdPreferenceHelper;->contentResolver:Landroid/content/ContentResolver;

    invoke-static {v0, p1, p2}, Landroid/provider/Settings$Secure;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    goto :goto_30

    :pswitch_2a  #0x0
    iget-object v0, p0, Landroidx/preference/EdPreferenceHelper;->contentResolver:Landroid/content/ContentResolver;

    invoke-static {v0, p1, p2}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    nop

    :goto_30
    return-void

    nop

    :pswitch_data_32
    .packed-switch 0x0
        :pswitch_2a  #00000000
        :pswitch_24  #00000001
        :pswitch_1e  #00000002
    .end packed-switch
.end method

.method protected putPropBoolean(Ljava/lang/String;Z)V
    .registers 5

    :try_start_0
    invoke-static {p2}, Ljava/lang/Boolean;->toString(Z)Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_7} :catch_8

    goto :goto_e

    :catch_8
    move-exception v0

    const-string v1, "Target Prop isn\'t write-able"

    invoke-virtual {p0, v1}, Landroidx/preference/EdPreferenceHelper;->showToast(Ljava/lang/String;)V

    :goto_e
    return-void
.end method

.method protected putPropString(Ljava/lang/String;Ljava/lang/String;)V
    .registers 5

    :try_start_0
    invoke-static {p1, p2}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_3} :catch_4

    goto :goto_a

    :catch_4
    move-exception v0

    const-string v1, "Target Prop isn\'t write-able"

    invoke-virtual {p0, v1}, Landroidx/preference/EdPreferenceHelper;->showToast(Ljava/lang/String;)V

    :goto_a
    return-void
.end method

.method public putString(Ljava/lang/String;Ljava/lang/String;I)V
    .registers 6

    packed-switch p3, :pswitch_data_32

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "ED_PREFS "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Landroidx/preference/EdPreferenceHelper;->BUILD_VER:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "Invalid type for putInt"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_30

    :pswitch_1e  #0x2
    iget-object v0, p0, Landroidx/preference/EdPreferenceHelper;->contentResolver:Landroid/content/ContentResolver;

    invoke-static {v0, p1, p2}, Landroid/provider/Settings$Global;->putString(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;)Z

    goto :goto_30

    :pswitch_24  #0x1
    iget-object v0, p0, Landroidx/preference/EdPreferenceHelper;->contentResolver:Landroid/content/ContentResolver;

    invoke-static {v0, p1, p2}, Landroid/provider/Settings$Secure;->putString(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;)Z

    goto :goto_30

    :pswitch_2a  #0x0
    iget-object v0, p0, Landroidx/preference/EdPreferenceHelper;->contentResolver:Landroid/content/ContentResolver;

    invoke-static {v0, p1, p2}, Landroid/provider/Settings$System;->putString(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;)Z

    nop

    :goto_30
    return-void

    nop

    :pswitch_data_32
    .packed-switch 0x0
        :pswitch_2a  #00000000
        :pswitch_24  #00000001
        :pswitch_1e  #00000002
    .end packed-switch
.end method

.method public sendIntent(Ljava/lang/String;)V
    .registers 4

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Sending Broadcust on: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "ED_PREFS "

    invoke-static {v1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    if-eqz p1, :cond_2c

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_21

    goto :goto_2c

    :cond_21
    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0, p1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Landroidx/preference/EdPreferenceHelper;->context:Landroid/content/Context;

    invoke-virtual {v1, v0}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    return-void

    :cond_2c
    :goto_2c
    return-void
.end method

.method protected showToast(Ljava/lang/String;)V
    .registers 4

    iget-object v0, p0, Landroidx/preference/EdPreferenceHelper;->context:Landroid/content/Context;

    const/4 v1, 0x0

    invoke-static {v0, p1, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    return-void
.end method

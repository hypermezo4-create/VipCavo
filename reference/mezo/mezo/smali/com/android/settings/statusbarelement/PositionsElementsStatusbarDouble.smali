# classes10.dex

.class public Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;
.super Landroid/widget/FrameLayout;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$H;,
        Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;
    }
.end annotation


# static fields
.field private static final TAG:Ljava/lang/String; = "settings_element"

.field private static final codePositionAfterEvent:I = 0x65

.field private static final init:I = 0x64

.field private static final nameElement:[Ljava/lang/String;


# instance fields
.field private CenterCameraEnable:Z

.field private final defSettings:Ljava/lang/String;

.field private isDoubleStatusBar:Z

.field private isDrip:Z

.field private isNight:Z

.field private mBorderZoneHeight:F

.field private final mContext:Landroid/content/Context;

.field private mElementHeight:F

.field private mElementWidth:F

.field private final mElements:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;",
            ">;"
        }
    .end annotation
.end field

.field private final mHandler:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$H;

.field private mHeight:F

.field mLeftCenterZoneEnd:F

.field private mMargins:F

.field private mMaxWidth:F

.field mRightCenterZoneStart:F

.field private settingsString:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .registers 3

    const/16 v0, 0xa

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "elem_status"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, "elem_clock"

    aput-object v2, v0, v1

    const/4 v1, 0x2

    const-string v2, "elem_bat"

    aput-object v2, v0, v1

    const/4 v1, 0x3

    const-string v2, "elem_net1"

    aput-object v2, v0, v1

    const/4 v1, 0x4

    const-string v2, "elem_net2"

    aput-object v2, v0, v1

    const/4 v1, 0x5

    const-string v2, "elem_wifi"

    aput-object v2, v0, v1

    const/4 v1, 0x6

    const-string v2, "elem_notif"

    aput-object v2, v0, v1

    const/4 v1, 0x7

    const-string v2, "elem_speed"

    aput-object v2, v0, v1

    const/16 v1, 0x8

    const-string v2, "elem_weather"

    aput-object v2, v0, v1

    const/16 v1, 0x9

    const-string v2, "elem_date"

    aput-object v2, v0, v1

    sput-object v0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->nameElement:[Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .registers 5

    const/4 v1, 0x1

    invoke-direct {p0, p1, p2}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    iput-boolean v1, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->CenterCameraEnable:Z

    const-string v0, "elem_status.33;elem_clock.21;elem_bat.31;elem_net1.1;elem_net2.11;elem_wifi.2;elem_notif.22;elem_speed.3;elem_weather.32;elem_date.12;"

    iput-object v0, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->defSettings:Ljava/lang/String;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mElements:Ljava/util/ArrayList;

    iput-boolean v1, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->isDoubleStatusBar:Z

    iput-object p1, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mContext:Landroid/content/Context;

    new-instance v0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$H;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$H;-><init>(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$1;)V

    iput-object v0, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mHandler:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$H;

    invoke-direct {p0}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->init()V

    return-void
.end method

.method private DrawableToID(Ljava/lang/String;)I
    .registers 5

    iget-object v0, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "drawable"

    iget-object v2, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, p1, v1, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method private IDtoID(Ljava/lang/String;)I
    .registers 5

    iget-object v0, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "id"

    iget-object v2, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, p1, v1, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method static synthetic access$1000(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;)F
    .registers 2

    iget v0, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mMargins:F

    return v0
.end method

.method static synthetic access$1200(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;)F
    .registers 2

    iget v0, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mMaxWidth:F

    return v0
.end method

.method static synthetic access$1300(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;)F
    .registers 2

    iget v0, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mElementWidth:F

    return v0
.end method

.method static synthetic access$1400(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;)F
    .registers 2

    iget v0, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mHeight:F

    return v0
.end method

.method static synthetic access$1500(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;)F
    .registers 2

    iget v0, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mElementHeight:F

    return v0
.end method

.method static synthetic access$1600(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;I)Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;
    .registers 3

    invoke-direct {p0, p1}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->getElementOnPosition(I)Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$1700(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;FZ)I
    .registers 4

    invoke-direct {p0, p1, p2}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->getEmptyPozition(FZ)I

    move-result v0

    return v0
.end method

.method static synthetic access$1800(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;)V
    .registers 1

    invoke-direct {p0}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->codePositionAfterEvent()V

    return-void
.end method

.method static synthetic access$1900(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;)Z
    .registers 2

    iget-boolean v0, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->isDoubleStatusBar:Z

    return v0
.end method

.method static synthetic access$2000(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;FZ)V
    .registers 3

    invoke-direct {p0, p1, p2}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->upPosition(FZ)V

    return-void
.end method

.method static synthetic access$2100(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;Z)Z
    .registers 3

    invoke-direct {p0, p1}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->getFlagAllElements(Z)Z

    move-result v0

    return v0
.end method

.method static synthetic access$2200(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;FZ)V
    .registers 3

    invoke-direct {p0, p1, p2}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->downPosition(FZ)V

    return-void
.end method

.method static synthetic access$2300(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;FFZZ)V
    .registers 5

    invoke-direct {p0, p1, p2, p3, p4}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->sendMovePosition(FFZZ)V

    return-void
.end method

.method static synthetic access$2700(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;)Ljava/util/ArrayList;
    .registers 2

    iget-object v0, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mElements:Ljava/util/ArrayList;

    return-object v0
.end method

.method static synthetic access$2800(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;)V
    .registers 1

    invoke-direct {p0}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->init()V

    return-void
.end method

.method static synthetic access$900(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;)Z
    .registers 2

    invoke-direct {p0}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->getTouchAllElements()Z

    move-result v0

    return v0
.end method

.method private codePosition()V
    .registers 7

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mElements:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_b
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_33

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;

    invoke-static {v2}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->access$100(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "."

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-static {v2}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->access$300(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;)I

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ";"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_b

    :cond_33
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    iget-object v4, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->settingsString:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_54

    :try_start_3f
    iget-object v3, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    const-string v4, "status_bar_elem_position"

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v3, v4, v5}, Landroid/provider/Settings$System;->putString(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;)Z
    :try_end_4e
    .catch Ljava/lang/Exception; {:try_start_3f .. :try_end_4e} :catch_55

    :goto_4e
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->settingsString:Ljava/lang/String;

    :cond_54
    return-void

    :catch_55
    move-exception v0

    iget-object v3, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mContext:Landroid/content/Context;

    invoke-static {v3}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v3

    invoke-interface {v3}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    const-string v4, "status_bar_elem_position"

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-interface {v3, v4, v5}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    invoke-interface {v3}, Landroid/content/SharedPreferences$Editor;->apply()V

    goto :goto_4e
.end method

.method private codePositionAfterEvent()V
    .registers 5

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->getFlagAllElements(Z)Z

    move-result v0

    if-nez v0, :cond_d

    invoke-direct {p0}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->getTouchAllElements()Z

    move-result v0

    if-eqz v0, :cond_17

    :cond_d
    iget-object v0, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mHandler:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$H;

    const/16 v1, 0x65

    const-wide/16 v2, 0x64

    invoke-virtual {v0, v1, v2, v3}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$H;->sendEmptyMessageDelayed(IJ)Z

    :goto_16
    return-void

    :cond_17
    invoke-direct {p0}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->codePosition()V

    goto :goto_16
.end method

.method private createView(Ljava/lang/String;)Landroid/widget/ImageView;
    .registers 5
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "UseCompatLoadingForDrawables"
        }
    .end annotation

    new-instance v0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;

    iget-object v1, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mContext:Landroid/content/Context;

    invoke-direct {v0, p0, v1}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;-><init>(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;Landroid/content/Context;)V

    invoke-virtual {p0}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-direct {p0, p1}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->DrawableToID(Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v1, v2}, Landroid/content/Context;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    invoke-direct {p0, p1}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->IDtoID(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setId(I)V

    return-object v0
.end method

.method private decodePosition()V
    .registers 13

    const/4 v11, 0x0

    const/4 v4, 0x0

    iget-object v8, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mContext:Landroid/content/Context;

    invoke-virtual {v8}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v8

    const-string v9, "status_bar_elem_position"

    invoke-static {v8, v9}, Landroid/provider/Settings$System;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    if-nez v6, :cond_1e

    iget-object v8, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mContext:Landroid/content/Context;

    invoke-static {v8}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v8

    const-string v9, "status_bar_elem_position"

    const-string v10, "elem_status.33;elem_clock.21;elem_bat.31;elem_net1.1;elem_net2.11;elem_wifi.2;elem_notif.22;elem_speed.3;elem_weather.32;elem_date.12;"

    invoke-interface {v8, v9, v10}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    :cond_1e
    const-string v8, "elem_prompt"

    invoke-virtual {v6, v8}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v8

    if-eqz v8, :cond_28

    const-string v6, "elem_status.33;elem_clock.21;elem_bat.31;elem_net1.1;elem_net2.11;elem_wifi.2;elem_notif.22;elem_speed.3;elem_weather.32;elem_date.12;"

    :cond_28
    iput-object v6, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->settingsString:Ljava/lang/String;

    const/4 v1, 0x0

    :goto_2b
    iget-object v8, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mElements:Ljava/util/ArrayList;

    invoke-virtual {v8}, Ljava/util/ArrayList;->size()I

    move-result v8

    if-ge v1, v8, :cond_89

    :try_start_33
    const-string v8, "."

    invoke-virtual {v6, v8}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v8

    add-int/lit8 v8, v8, 0x1

    const-string v9, ";"

    invoke-virtual {v6, v9}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v9

    invoke-virtual {v6, v8, v9}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v8

    invoke-static {v8}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v5

    const/4 v8, 0x0

    const-string v9, "."

    invoke-virtual {v6, v9}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v9

    invoke-virtual {v6, v8, v9}, Ljava/lang/String;->substring(II)Ljava/lang/String;
    :try_end_53
    .catch Ljava/lang/Exception; {:try_start_33 .. :try_end_53} :catch_71

    move-result-object v3

    invoke-direct {p0, v3}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->getElementForName(Ljava/lang/String;)Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;

    move-result-object v7

    invoke-virtual {v7, v5}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->setPosition(I)V

    const/4 v8, 0x1

    invoke-static {v7, v8}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->access$202(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;Z)Z

    invoke-virtual {v7, v11}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->moveToPosition(Z)V

    const-string v8, ";"

    invoke-virtual {v6, v8}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v8

    add-int/lit8 v8, v8, 0x1

    invoke-virtual {v6, v8}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v6

    add-int/lit8 v1, v1, 0x1

    goto :goto_2b

    :catch_71
    move-exception v0

    const-string v8, "settings_element"

    const-string v9, "decodePosition: first start"

    invoke-static {v8, v9}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :try_start_79
    iget-object v8, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mContext:Landroid/content/Context;

    invoke-virtual {v8}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v8

    const-string v9, "status_bar_elem_position"

    const-string v10, "elem_status.33;elem_clock.21;elem_bat.31;elem_net1.1;elem_net2.11;elem_wifi.2;elem_notif.22;elem_speed.3;elem_weather.32;elem_date.12;"

    invoke-static {v8, v9, v10}, Landroid/provider/Settings$System;->putString(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;)Z
    :try_end_86
    .catch Ljava/lang/Exception; {:try_start_79 .. :try_end_86} :catch_8a

    invoke-direct {p0}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->decodePosition()V

    :cond_89
    :goto_89
    return-void

    :catch_8a
    move-exception v2

    iget-object v8, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mContext:Landroid/content/Context;

    invoke-static {v8}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v8

    invoke-interface {v8}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v8

    const-string v9, "status_bar_elem_position"

    const-string v10, "elem_status.33;elem_clock.21;elem_bat.31;elem_net1.1;elem_net2.11;elem_wifi.2;elem_notif.22;elem_speed.3;elem_weather.32;elem_date.12;"

    invoke-interface {v8, v9, v10}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v8

    invoke-interface {v8}, Landroid/content/SharedPreferences$Editor;->apply()V

    invoke-direct {p0}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->decodePosition()V

    goto :goto_89
.end method

.method private downPosition(FZ)V
    .registers 9

    invoke-direct {p0, p1, p2}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->sectorOfdX(FZ)I

    move-result v2

    invoke-direct {p0, p1, p2}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->getEmptyPozition(FZ)I

    move-result v1

    iget-object v4, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mElements:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :cond_e
    :goto_e
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_2e

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;

    invoke-static {v3}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->access$300(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;)I

    move-result v0

    if-le v0, v2, :cond_e

    add-int/lit8 v5, v2, 0xa

    if-ge v0, v5, :cond_e

    if-le v0, v1, :cond_e

    invoke-static {v3}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->access$310(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;)I

    const/4 v5, 0x1

    invoke-virtual {v3, v5}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->moveToPosition(Z)V

    goto :goto_e

    :cond_2e
    return-void
.end method

.method private getBackPicture()Landroid/graphics/drawable/Drawable;
    .registers 16

    const/high16 v14, 0x40400000  # 3.0f

    const/high16 v13, 0x40000000  # 2.0f

    invoke-virtual {p0}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->getContext()Landroid/content/Context;

    move-result-object v1

    const/16 v2, 0xa

    invoke-static {v1, v2}, Landroid/Utils/ImageUtils;->convertDpToPx(Landroid/content/Context;I)I

    move-result v1

    mul-int/lit8 v1, v1, 0x2

    int-to-float v10, v1

    invoke-virtual {p0}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->getParent()Landroid/view/ViewParent;

    move-result-object v1

    check-cast v1, Landroid/widget/LinearLayout;

    invoke-virtual {v1}, Landroid/widget/LinearLayout;->getBackground()Landroid/graphics/drawable/Drawable;

    move-result-object v9

    if-eqz v9, :cond_dd

    iget v1, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mMaxWidth:F

    float-to-int v1, v1

    iget v2, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mHeight:F

    add-float/2addr v2, v10

    float-to-int v2, v2

    sget-object v3, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {v1, v2, v3}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v7

    iget-boolean v1, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->isNight:Z

    if-eqz v1, :cond_d5

    const-string v1, "#40ffffff"

    :goto_30
    invoke-static {v1}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v6

    const-string v1, "#ff00e2ff"

    invoke-static {v1}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v11

    iget-boolean v1, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->isNight:Z

    if-eqz v1, :cond_d9

    const-string v1, "#ffffffff"

    :goto_40
    invoke-static {v1}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v8

    new-instance v0, Landroid/graphics/Canvas;

    invoke-direct {v0, v7}, Landroid/graphics/Canvas;-><init>(Landroid/graphics/Bitmap;)V

    new-instance v5, Landroid/graphics/Paint;

    invoke-direct {v5}, Landroid/graphics/Paint;-><init>()V

    invoke-virtual {v5, v6}, Landroid/graphics/Paint;->setColor(I)V

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v5, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    const/4 v1, 0x0

    iget v2, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mHeight:F

    div-float/2addr v2, v13

    iget v3, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mBorderZoneHeight:F

    div-float/2addr v3, v13

    sub-float/2addr v2, v3

    float-to-int v2, v2

    int-to-float v2, v2

    div-float v3, v10, v13

    add-float/2addr v2, v3

    iget v3, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mMaxWidth:F

    float-to-int v3, v3

    int-to-float v3, v3

    iget v4, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mHeight:F

    div-float/2addr v4, v13

    iget v12, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mBorderZoneHeight:F

    add-float/2addr v4, v12

    float-to-int v4, v4

    int-to-float v4, v4

    div-float v12, v10, v13

    add-float/2addr v4, v12

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawRect(FFFFLandroid/graphics/Paint;)V

    invoke-virtual {v5, v8}, Landroid/graphics/Paint;->setColor(I)V

    const/high16 v1, 0x40c00000  # 6.0f

    invoke-virtual {v5, v1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    iget v1, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mMaxWidth:F

    div-float/2addr v1, v13

    iget v2, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mElementWidth:F

    sub-float/2addr v1, v2

    iput v1, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mLeftCenterZoneEnd:F

    iget v1, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mMaxWidth:F

    div-float/2addr v1, v13

    iget v2, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mElementWidth:F

    add-float/2addr v1, v2

    iput v1, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mRightCenterZoneStart:F

    iget v1, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mMaxWidth:F

    div-float/2addr v1, v13

    sub-float/2addr v1, v14

    div-float v2, v10, v13

    iget v3, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mMaxWidth:F

    div-float/2addr v3, v13

    sub-float/2addr v3, v14

    iget v4, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mHeight:F

    div-float/2addr v4, v13

    iget v12, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mBorderZoneHeight:F

    div-float/2addr v12, v13

    sub-float/2addr v4, v12

    div-float v12, v10, v13

    add-float/2addr v4, v12

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    iget v1, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mMaxWidth:F

    div-float/2addr v1, v13

    sub-float/2addr v1, v14

    iget v2, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mHeight:F

    div-float/2addr v2, v13

    iget v3, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mBorderZoneHeight:F

    add-float/2addr v2, v3

    div-float v3, v10, v13

    add-float/2addr v2, v3

    iget v3, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mMaxWidth:F

    div-float/2addr v3, v13

    sub-float/2addr v3, v14

    iget v4, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mHeight:F

    div-float v12, v10, v13

    add-float/2addr v4, v12

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    new-instance v1, Landroid/graphics/drawable/LayerDrawable;

    const/4 v2, 0x2

    new-array v2, v2, [Landroid/graphics/drawable/Drawable;

    const/4 v3, 0x0

    aput-object v9, v2, v3

    const/4 v3, 0x1

    new-instance v4, Landroid/graphics/drawable/BitmapDrawable;

    invoke-virtual {p0}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->getResources()Landroid/content/res/Resources;

    move-result-object v12

    invoke-direct {v4, v12, v7}, Landroid/graphics/drawable/BitmapDrawable;-><init>(Landroid/content/res/Resources;Landroid/graphics/Bitmap;)V

    aput-object v4, v2, v3

    invoke-direct {v1, v2}, Landroid/graphics/drawable/LayerDrawable;-><init>([Landroid/graphics/drawable/Drawable;)V

    :goto_d4
    return-object v1

    :cond_d5
    const-string v1, "#40000000"

    goto/16 :goto_30

    :cond_d9
    const-string v1, "#ff000000"

    goto/16 :goto_40

    :cond_dd
    const/4 v1, 0x0

    goto :goto_d4
.end method

.method private getElementForName(Ljava/lang/String;)Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;
    .registers 5

    iget-object v1, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mElements:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_6
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1d

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;

    invoke-static {v0}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->access$100(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_6

    :goto_1c
    return-object v0

    :cond_1d
    iget-object v1, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mElements:Ljava/util/ArrayList;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;

    move-object v0, v1

    goto :goto_1c
.end method

.method private getElementOnPosition(I)Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;
    .registers 5

    iget-object v1, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mElements:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_6
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_19

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;

    invoke-static {v0}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->access$300(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;)I

    move-result v2

    if-ne v2, p1, :cond_6

    :goto_18
    return-object v0

    :cond_19
    const/4 v0, 0x0

    goto :goto_18
.end method

.method private getEmptyPozition(FZ)I
    .registers 9

    invoke-direct {p0, p1, p2}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->sectorOfdX(FZ)I

    move-result v2

    add-int/lit8 v1, v2, 0x1

    :goto_6
    iget-object v4, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mElements:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v4

    add-int/2addr v4, v2

    add-int/lit8 v4, v4, 0x1

    if-ge v1, v4, :cond_31

    const/4 v0, 0x0

    iget-object v4, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mElements:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :cond_18
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_2b

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;

    invoke-static {v3}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->access$300(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;)I

    move-result v5

    if-ne v5, v1, :cond_18

    const/4 v0, 0x1

    :cond_2b
    if-nez v0, :cond_2e

    :goto_2d
    return v1

    :cond_2e
    add-int/lit8 v1, v1, 0x1

    goto :goto_6

    :cond_31
    iget-object v4, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mElements:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v1

    goto :goto_2d
.end method

.method private getFlagAllElements(Z)Z
    .registers 6

    const/4 v0, 0x0

    iget-object v2, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mElements:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_7
    :goto_7
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1f

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;

    invoke-static {v1}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->access$400(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;)Z

    move-result v3

    if-eqz v3, :cond_7

    if-eqz p1, :cond_1d

    const/4 p1, 0x0

    goto :goto_7

    :cond_1d
    const/4 v0, 0x1

    goto :goto_7

    :cond_1f
    return v0
.end method

.method private getPositionOfDx(FZ)I
    .registers 8

    const/16 v1, 0x33

    iget-object v3, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mElements:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_8
    :goto_8
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_34

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;

    invoke-virtual {v2}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->getX()F

    move-result v0

    invoke-static {v2}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->access$500(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;)Z

    move-result v4

    if-nez v4, :cond_8

    invoke-static {v2}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->access$700(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;)Z

    move-result v4

    if-ne v4, p2, :cond_8

    cmpl-float v4, p1, v0

    if-ltz v4, :cond_8

    iget v4, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mElementWidth:F

    add-float/2addr v4, v0

    cmpg-float v4, p1, v4

    if-gtz v4, :cond_8

    invoke-static {v2}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->access$300(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;)I

    move-result v1

    goto :goto_8

    :cond_34
    return v1
.end method

.method private getTouchAllElements()Z
    .registers 5

    const/4 v0, 0x0

    iget-object v2, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mElements:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_7
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1a

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;

    invoke-static {v1}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->access$500(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;)Z

    move-result v3

    if-eqz v3, :cond_7

    const/4 v0, 0x1

    :cond_1a
    return v0
.end method

.method private init()V
    .registers 13

    const/high16 v8, 0x40000000  # 2.0f

    const/4 v7, 0x0

    const/4 v6, 0x0

    iput-boolean v6, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->isDrip:Z

    invoke-virtual {p0}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->getWidth()I

    move-result v5

    int-to-float v5, v5

    iput v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mMaxWidth:F

    invoke-virtual {p0}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->getHeight()I

    move-result v5

    int-to-float v5, v5

    iput v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mHeight:F

    iget v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mHeight:F

    cmpl-float v5, v5, v7

    if-eqz v5, :cond_20

    iget v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mMaxWidth:F

    cmpl-float v5, v5, v7

    if-nez v5, :cond_2a

    :cond_20
    iget-object v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mHandler:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$H;

    const/16 v6, 0x64

    const-wide/16 v8, 0x32

    invoke-virtual {v5, v6, v8, v9}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$H;->sendEmptyMessageDelayed(IJ)Z

    :goto_29
    return-void

    :cond_2a
    iget-object v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mContext:Landroid/content/Context;

    const-string v7, "window"

    invoke-virtual {v5, v7}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Landroid/view/WindowManager;

    invoke-interface {v5}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v0

    new-instance v1, Landroid/util/DisplayMetrics;

    invoke-direct {v1}, Landroid/util/DisplayMetrics;-><init>()V

    invoke-virtual {v0, v1}, Landroid/view/Display;->getRealMetrics(Landroid/util/DisplayMetrics;)V

    iget v5, v1, Landroid/util/DisplayMetrics;->widthPixels:I

    int-to-float v5, v5

    iget v7, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mMaxWidth:F

    sub-float/2addr v5, v7

    div-float/2addr v5, v8

    iput v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mMargins:F

    iget v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mMaxWidth:F

    const/high16 v7, 0x41800000  # 16.0f

    div-float/2addr v5, v7

    iput v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mElementWidth:F

    const/high16 v5, 0x41200000  # 10.0f

    iget-object v7, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mContext:Landroid/content/Context;

    invoke-virtual {v7}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v7

    invoke-virtual {v7}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v7

    iget v7, v7, Landroid/util/DisplayMetrics;->density:F

    mul-float/2addr v5, v7

    iput v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mBorderZoneHeight:F

    iget v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mHeight:F

    div-float/2addr v5, v8

    iget v7, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mBorderZoneHeight:F

    sub-float/2addr v5, v7

    iput v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mElementHeight:F

    sget-object v7, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->nameElement:[Ljava/lang/String;

    array-length v8, v7

    move v5, v6

    :goto_6d
    if-ge v5, v8, :cond_90

    aget-object v2, v7, v5

    invoke-direct {p0, v2}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->createView(Ljava/lang/String;)Landroid/widget/ImageView;

    move-result-object v4

    check-cast v4, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;

    invoke-static {v4, v2}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->access$102(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;Ljava/lang/String;)Ljava/lang/String;

    iget-object v9, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mElements:Ljava/util/ArrayList;

    invoke-virtual {v9, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    new-instance v9, Landroid/widget/FrameLayout$LayoutParams;

    iget v10, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mElementWidth:F

    float-to-int v10, v10

    iget v11, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mElementHeight:F

    float-to-int v11, v11

    invoke-direct {v9, v10, v11}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    invoke-virtual {p0, v4, v9}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    add-int/lit8 v5, v5, 0x1

    goto :goto_6d

    :cond_90
    invoke-virtual {p0}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->getContext()Landroid/content/Context;

    move-result-object v5

    const-string v7, "uimode"

    invoke-virtual {v5, v7}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/app/UiModeManager;

    invoke-virtual {v3}, Landroid/app/UiModeManager;->getNightMode()I

    move-result v5

    const/4 v7, 0x2

    if-ne v5, v7, :cond_b8

    const/4 v5, 0x1

    :goto_a4
    iput-boolean v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->isNight:Z

    invoke-virtual {p0}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->getParent()Landroid/view/ViewParent;

    move-result-object v5

    check-cast v5, Landroid/widget/LinearLayout;

    invoke-direct {p0}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->getBackPicture()Landroid/graphics/drawable/Drawable;

    move-result-object v6

    invoke-virtual {v5, v6}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    invoke-direct {p0}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->decodePosition()V

    goto/16 :goto_29

    :cond_b8
    move v5, v6

    goto :goto_a4
.end method

.method private sectorOfdX(FZ)I
    .registers 7

    const/high16 v3, 0x40000000  # 2.0f

    if-eqz p2, :cond_14

    iget v1, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mMaxWidth:F

    div-float/2addr v1, v3

    iget v2, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mElementWidth:F

    sub-float/2addr v1, v2

    cmpg-float v1, p1, v1

    if-gez v1, :cond_11

    const/16 v0, 0x14

    :goto_10
    return v0

    :cond_11
    const/16 v0, 0x1e

    goto :goto_10

    :cond_14
    iget v1, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mElementWidth:F

    div-float/2addr v1, v3

    add-float/2addr v1, p1

    iget v2, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mMaxWidth:F

    div-float/2addr v2, v3

    const/high16 v3, 0x40400000  # 3.0f

    sub-float/2addr v2, v3

    cmpg-float v1, v1, v2

    if-gez v1, :cond_24

    const/4 v0, 0x0

    :goto_23
    goto :goto_10

    :cond_24
    const/16 v0, 0xa

    goto :goto_23
.end method

.method private sendMovePosition(FFZZ)V
    .registers 12

    const/4 v2, 0x1

    const/4 v3, 0x0

    const/high16 v6, 0x40000000  # 2.0f

    if-eqz p4, :cond_1f

    iget v4, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mHeight:F

    div-float/2addr v4, v6

    iget v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mElementHeight:F

    div-float/2addr v5, v6

    sub-float/2addr v4, v5

    cmpl-float v4, p2, v4

    if-lez v4, :cond_1b

    move v0, v2

    :goto_12
    if-nez v0, :cond_1d

    :goto_14
    invoke-direct {p0, p1, v2}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->downPosition(FZ)V

    invoke-direct {p0, p1, v0}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->upPosition(FZ)V

    :cond_1a
    return-void

    :cond_1b
    move v0, v3

    goto :goto_12

    :cond_1d
    move v2, v3

    goto :goto_14

    :cond_1f
    iget-object v2, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mElements:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_25
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1a

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;

    invoke-static {v1, p1, p2, p3}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->access$600(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;FFZ)V

    goto :goto_25
.end method

.method private upPosition(FZ)V
    .registers 8

    iget v2, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mElementWidth:F

    const/high16 v3, 0x40000000  # 2.0f

    div-float/2addr v2, v3

    add-float/2addr v2, p1

    invoke-direct {p0, v2, p2}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->getPositionOfDx(FZ)I

    move-result v0

    const/16 v2, 0x33

    if-eq v0, v2, :cond_48

    if-eqz v0, :cond_48

    iget-object v2, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mElements:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_16
    :goto_16
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_48

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;

    invoke-static {v1}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->access$400(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;)Z

    move-result v3

    if-nez v3, :cond_16

    invoke-static {v1}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->access$300(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;)I

    move-result v3

    if-eqz v3, :cond_16

    invoke-static {v1}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->access$300(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;)I

    move-result v3

    if-lt v3, v0, :cond_16

    invoke-static {v1}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->access$300(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;)I

    move-result v3

    div-int/lit8 v4, v0, 0xa

    mul-int/lit8 v4, v4, 0xa

    add-int/lit8 v4, v4, 0xa

    if-ge v3, v4, :cond_16

    invoke-static {v1}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->access$308(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;)I

    const/4 v3, 0x1

    invoke-virtual {v1, v3}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->moveToPosition(Z)V

    goto :goto_16

    :cond_48
    return-void
.end method


# virtual methods
.method public onCoordinateAdd()V
    .registers 1

    return-void
.end method

.method protected onDetachedFromWindow()V
    .registers 2

    goto/32 :goto_a

    nop

    :goto_4
    iget-object v0, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mElements:Ljava/util/ArrayList;

    goto/32 :goto_11

    nop

    :goto_a
    invoke-virtual {p0}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->removeAllViews()V

    goto/32 :goto_4

    nop

    :goto_11
    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    goto/32 :goto_19

    nop

    :goto_18
    return-void

    :goto_19
    invoke-super {p0}, Landroid/widget/FrameLayout;->onDetachedFromWindow()V

    goto/32 :goto_18

    nop
.end method

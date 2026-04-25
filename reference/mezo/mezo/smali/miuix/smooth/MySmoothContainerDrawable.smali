# classes11.dex

.class public Lmiuix/smooth/MySmoothContainerDrawable;
.super Lmiuix/smooth/SmoothContainerDrawable;


# static fields
.field static TAG:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .registers 1

    const-string v0, "MySmoothContainerDrawable"

    sput-object v0, Lmiuix/smooth/MySmoothContainerDrawable;->TAG:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .registers 1

    invoke-direct {p0}, Lmiuix/smooth/SmoothContainerDrawable;-><init>()V

    return-void
.end method


# virtual methods
.method public inflate(Landroid/content/res/Resources;Lorg/xmlpull/v1/XmlPullParser;Landroid/util/AttributeSet;Landroid/content/res/Resources$Theme;)V
    .registers 9
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/xmlpull/v1/XmlPullParserException;
        }
    .end annotation

    invoke-super {p0, p1, p2, p3, p4}, Lmiuix/smooth/SmoothContainerDrawable;->inflate(Landroid/content/res/Resources;Lorg/xmlpull/v1/XmlPullParser;Landroid/util/AttributeSet;Landroid/content/res/Resources$Theme;)V

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "card_bg_stroke_color"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-static {}, Landroid/Utils/Utils;->isNightMode()Z

    move-result v2

    if-eqz v2, :cond_37

    const-string v2, "_dark"

    :goto_16
    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const v0, -0xff0100

    invoke-static {v2, v0}, Landroid/preference/SettingsMezoHelper;->getIntofSettings(Ljava/lang/String;I)I

    move-result v0

    const-string v2, "card_bg_stroke_width"

    const/4 v1, 0x2

    invoke-static {v2, v1}, Landroid/preference/SettingsMezoHelper;->getIntofSettings(Ljava/lang/String;I)I

    move-result v1

    if-lez v1, :cond_31

    invoke-virtual {p0, v1}, Lmiuix/smooth/MySmoothContainerDrawable;->setStrokeWidth(I)V

    :cond_31
    if-eqz v0, :cond_36

    invoke-virtual {p0, v0}, Lmiuix/smooth/MySmoothContainerDrawable;->setStrokeColor(I)V

    :cond_36
    return-void

    :cond_37
    const-string v2, ""

    goto :goto_16
.end method

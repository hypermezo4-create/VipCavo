# classes10.dex

.class public Landroidx/preference/MiuiMiniPreferenceScreen;
.super Landroidx/preference/DialogPreference;
.source "MiuiMiniPreferenceScreen.java"


# instance fields
.field helper:Landroidx/preference/MiuiPreferenceHelper;

.field private final xmlName:Ljava/lang/String;


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .registers 5

    invoke-direct {p0, p1, p2}, Landroidx/preference/DialogPreference;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    new-instance v0, Landroidx/preference/MiuiPreferenceHelper;

    invoke-direct {v0, p1, p2}, Landroidx/preference/MiuiPreferenceHelper;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    iput-object v0, p0, Landroidx/preference/MiuiMiniPreferenceScreen;->helper:Landroidx/preference/MiuiPreferenceHelper;

    iget-object v0, p0, Landroidx/preference/MiuiMiniPreferenceScreen;->helper:Landroidx/preference/MiuiPreferenceHelper;

    const-string v1, "xmlName"

    invoke-virtual {v0, v1}, Landroidx/preference/MiuiPreferenceHelper;->getAttributeValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Landroidx/preference/MiuiMiniPreferenceScreen;->xmlName:Ljava/lang/String;

    iget-object v0, p0, Landroidx/preference/MiuiMiniPreferenceScreen;->xmlName:Ljava/lang/String;

    invoke-virtual {p0, v0}, Landroidx/preference/MiuiMiniPreferenceScreen;->setKey(Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method public getXmlIds()I
    .registers 5

    invoke-virtual {p0}, Landroidx/preference/MiuiMiniPreferenceScreen;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    iget-object v1, p0, Landroidx/preference/MiuiMiniPreferenceScreen;->xmlName:Ljava/lang/String;

    const-string v2, "xml"

    invoke-virtual {p0}, Landroidx/preference/MiuiMiniPreferenceScreen;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-virtual {v3}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v1, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public getXmlName()Ljava/lang/String;
    .registers 2

    iget-object v0, p0, Landroidx/preference/MiuiMiniPreferenceScreen;->xmlName:Ljava/lang/String;

    return-object v0
.end method

.method public performClick()V
    .registers 2
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "RestrictedApi"
        }
    .end annotation

    iget-object v0, p0, Landroidx/preference/MiuiMiniPreferenceScreen;->xmlName:Ljava/lang/String;

    if-eqz v0, :cond_7

    invoke-super {p0}, Landroidx/preference/DialogPreference;->performClick()V

    :cond_7
    return-void
.end method

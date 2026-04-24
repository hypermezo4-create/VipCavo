# classes10.dex

.class Landroidx/preference/XMiuiDropDownPreference$1;
.super Ljava/lang/Object;
.source "XMiuiDropDownPreference.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Landroidx/preference/XMiuiDropDownPreference;->init()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Landroidx/preference/XMiuiDropDownPreference;


# direct methods
.method constructor <init>(Landroidx/preference/XMiuiDropDownPreference;)V
    .registers 2

    iput-object p1, p0, Landroidx/preference/XMiuiDropDownPreference$1;->this$0:Landroidx/preference/XMiuiDropDownPreference;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .registers 2

    iget-object v0, p0, Landroidx/preference/XMiuiDropDownPreference$1;->this$0:Landroidx/preference/XMiuiDropDownPreference;

    invoke-static {v0}, Landroidx/preference/XMiuiDropDownPreference;->access$000(Landroidx/preference/XMiuiDropDownPreference;)V

    return-void
.end method

# classes10.dex

.class Landroidx/preferencecolor/PreferenceColorController$1$1;
.super Ljava/lang/Object;
.source "PreferenceColorController.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Landroidx/preferencecolor/PreferenceColorController$1;->onCustomChanged(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Landroidx/preferencecolor/PreferenceColorController$1;

.field final synthetic val$color:Landroidx/preferencecolor/PreferenceColorController$ColorImpl;


# direct methods
.method constructor <init>(Landroidx/preferencecolor/PreferenceColorController$1;Landroidx/preferencecolor/PreferenceColorController$ColorImpl;)V
    .registers 3

    iput-object p1, p0, Landroidx/preferencecolor/PreferenceColorController$1$1;->this$1:Landroidx/preferencecolor/PreferenceColorController$1;

    iput-object p2, p0, Landroidx/preferencecolor/PreferenceColorController$1$1;->val$color:Landroidx/preferencecolor/PreferenceColorController$ColorImpl;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .registers 2

    iget-object v0, p0, Landroidx/preferencecolor/PreferenceColorController$1$1;->val$color:Landroidx/preferencecolor/PreferenceColorController$ColorImpl;

    invoke-interface {v0}, Landroidx/preferencecolor/PreferenceColorController$ColorImpl;->onPreferenceColorChange()V

    return-void
.end method

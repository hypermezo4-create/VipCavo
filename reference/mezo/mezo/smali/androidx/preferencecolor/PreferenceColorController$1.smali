# classes10.dex

.class Landroidx/preferencecolor/PreferenceColorController$1;
.super Ljava/lang/Object;
.source "PreferenceColorController.java"

# interfaces
.implements Landroid/preference/CustomUpdater$CustomReceiver;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/preferencecolor/PreferenceColorController;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Landroidx/preferencecolor/PreferenceColorController;


# direct methods
.method constructor <init>(Landroidx/preferencecolor/PreferenceColorController;)V
    .registers 2

    iput-object p1, p0, Landroidx/preferencecolor/PreferenceColorController$1;->this$0:Landroidx/preferencecolor/PreferenceColorController;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCustomChanged(Ljava/lang/String;)V
    .registers 5

    const-string v1, "preference_color_update"

    invoke-virtual {v1, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_11

    iget-object v1, p0, Landroidx/preferencecolor/PreferenceColorController$1;->this$0:Landroidx/preferencecolor/PreferenceColorController;

    invoke-static {v1}, Landroidx/preferencecolor/PreferenceColorController;->access$000(Landroidx/preferencecolor/PreferenceColorController;)Landroidx/preferencecolor/PreferenceColorController$ColorData;

    move-result-object v1

    invoke-virtual {v1}, Landroidx/preferencecolor/PreferenceColorController$ColorData;->update()V

    :cond_11
    iget-object v1, p0, Landroidx/preferencecolor/PreferenceColorController$1;->this$0:Landroidx/preferencecolor/PreferenceColorController;

    invoke-static {v1}, Landroidx/preferencecolor/PreferenceColorController;->access$100(Landroidx/preferencecolor/PreferenceColorController;)Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_1b
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_30

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroidx/preferencecolor/PreferenceColorController$ColorImpl;

    new-instance v2, Landroidx/preferencecolor/PreferenceColorController$1$1;

    invoke-direct {v2, p0, v0}, Landroidx/preferencecolor/PreferenceColorController$1$1;-><init>(Landroidx/preferencecolor/PreferenceColorController$1;Landroidx/preferencecolor/PreferenceColorController$ColorImpl;)V

    invoke-interface {v0, v2}, Landroidx/preferencecolor/PreferenceColorController$ColorImpl;->post(Ljava/lang/Runnable;)Z

    goto :goto_1b

    :cond_30
    return-void
.end method

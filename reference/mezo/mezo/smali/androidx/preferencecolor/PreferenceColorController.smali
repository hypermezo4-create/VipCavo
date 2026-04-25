# classes10.dex

.class public Landroidx/preferencecolor/PreferenceColorController;
.super Ljava/lang/Object;
.source "PreferenceColorController.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/preferencecolor/PreferenceColorController$ColorImpl;,
        Landroidx/preferencecolor/PreferenceColorController$ColorData;
    }
.end annotation


# static fields
.field private static instance:Landroidx/preferencecolor/PreferenceColorController; = null

.field private static final updateKey:Ljava/lang/String; = "preference_color_update"


# instance fields
.field private final callBacks:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Landroidx/preferencecolor/PreferenceColorController$ColorImpl;",
            ">;"
        }
    .end annotation
.end field

.field private final colorData:Landroidx/preferencecolor/PreferenceColorController$ColorData;

.field private final customReceiver:Landroid/preference/CustomUpdater$CustomReceiver;

.field public labelIds:I

.field public seekBarIds:I

.field public summaryIds:I

.field public titleIds:I


# direct methods
.method private constructor <init>()V
    .registers 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Landroidx/preferencecolor/PreferenceColorController;->callBacks:Ljava/util/List;

    new-instance v0, Landroidx/preferencecolor/PreferenceColorController$1;

    invoke-direct {v0, p0}, Landroidx/preferencecolor/PreferenceColorController$1;-><init>(Landroidx/preferencecolor/PreferenceColorController;)V

    iput-object v0, p0, Landroidx/preferencecolor/PreferenceColorController;->customReceiver:Landroid/preference/CustomUpdater$CustomReceiver;

    new-instance v0, Landroidx/preferencecolor/PreferenceColorController$ColorData;

    invoke-direct {v0, p0}, Landroidx/preferencecolor/PreferenceColorController$ColorData;-><init>(Landroidx/preferencecolor/PreferenceColorController;)V

    iput-object v0, p0, Landroidx/preferencecolor/PreferenceColorController;->colorData:Landroidx/preferencecolor/PreferenceColorController$ColorData;

    iget-object v0, p0, Landroidx/preferencecolor/PreferenceColorController;->colorData:Landroidx/preferencecolor/PreferenceColorController$ColorData;

    invoke-virtual {v0}, Landroidx/preferencecolor/PreferenceColorController$ColorData;->update()V

    return-void
.end method

.method static synthetic access$000(Landroidx/preferencecolor/PreferenceColorController;)Landroidx/preferencecolor/PreferenceColorController$ColorData;
    .registers 2

    iget-object v0, p0, Landroidx/preferencecolor/PreferenceColorController;->colorData:Landroidx/preferencecolor/PreferenceColorController$ColorData;

    return-object v0
.end method

.method static synthetic access$100(Landroidx/preferencecolor/PreferenceColorController;)Ljava/util/List;
    .registers 2

    iget-object v0, p0, Landroidx/preferencecolor/PreferenceColorController;->callBacks:Ljava/util/List;

    return-object v0
.end method

.method public static getInstance()Landroidx/preferencecolor/PreferenceColorController;
    .registers 3

    const-class v2, Landroidx/preferencecolor/PreferenceColorController;

    monitor-enter v2

    :try_start_3
    sget-object v1, Landroidx/preferencecolor/PreferenceColorController;->instance:Landroidx/preferencecolor/PreferenceColorController;

    if-nez v1, :cond_e

    new-instance v1, Landroidx/preferencecolor/PreferenceColorController;

    invoke-direct {v1}, Landroidx/preferencecolor/PreferenceColorController;-><init>()V

    sput-object v1, Landroidx/preferencecolor/PreferenceColorController;->instance:Landroidx/preferencecolor/PreferenceColorController;

    :cond_e
    sget-object v0, Landroidx/preferencecolor/PreferenceColorController;->instance:Landroidx/preferencecolor/PreferenceColorController;

    monitor-exit v2

    return-object v0

    :catchall_12
    move-exception v1

    monitor-exit v2
    :try_end_14
    .catchall {:try_start_3 .. :try_end_14} :catchall_12

    throw v1
.end method

.method private updateIds(Landroid/content/Context;)V
    .registers 2

    return-void
.end method


# virtual methods
.method public addCallBack(Landroidx/preferencecolor/PreferenceColorController$ColorImpl;)V
    .registers 5

    iget-object v0, p0, Landroidx/preferencecolor/PreferenceColorController;->callBacks:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_13

    invoke-static {}, Landroid/preference/CustomUpdater;->getInstance()Landroid/preference/CustomUpdater;

    move-result-object v0

    iget-object v1, p0, Landroidx/preferencecolor/PreferenceColorController;->customReceiver:Landroid/preference/CustomUpdater$CustomReceiver;

    const-string v2, "preference_color_update"

    invoke-virtual {v0, v1, v2}, Landroid/preference/CustomUpdater;->addCustomReceiver(Landroid/preference/CustomUpdater$CustomReceiver;Ljava/lang/String;)V

    :cond_13
    iget v0, p0, Landroidx/preferencecolor/PreferenceColorController;->titleIds:I

    if-nez v0, :cond_1e

    invoke-interface {p1}, Landroidx/preferencecolor/PreferenceColorController$ColorImpl;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-direct {p0, v0}, Landroidx/preferencecolor/PreferenceColorController;->updateIds(Landroid/content/Context;)V

    :cond_1e
    iget-object v0, p0, Landroidx/preferencecolor/PreferenceColorController;->callBacks:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public getColorData()Landroidx/preferencecolor/PreferenceColorController$ColorData;
    .registers 2

    iget-object v0, p0, Landroidx/preferencecolor/PreferenceColorController;->colorData:Landroidx/preferencecolor/PreferenceColorController$ColorData;

    invoke-virtual {v0}, Landroidx/preferencecolor/PreferenceColorController$ColorData;->copy()Landroidx/preferencecolor/PreferenceColorController$ColorData;

    move-result-object v0

    return-object v0
.end method

.method public removeCallBack(Landroidx/preferencecolor/PreferenceColorController$ColorImpl;)V
    .registers 5

    iget-object v0, p0, Landroidx/preferencecolor/PreferenceColorController;->callBacks:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    iget-object v0, p0, Landroidx/preferencecolor/PreferenceColorController;->callBacks:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_18

    invoke-static {}, Landroid/preference/CustomUpdater;->getInstance()Landroid/preference/CustomUpdater;

    move-result-object v0

    iget-object v1, p0, Landroidx/preferencecolor/PreferenceColorController;->customReceiver:Landroid/preference/CustomUpdater$CustomReceiver;

    const-string v2, "preference_color_update"

    invoke-virtual {v0, v1, v2}, Landroid/preference/CustomUpdater;->removeCustomReceiver(Landroid/preference/CustomUpdater$CustomReceiver;Ljava/lang/String;)V

    :cond_18
    return-void
.end method

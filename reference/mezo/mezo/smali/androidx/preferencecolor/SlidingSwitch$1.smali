# classes10.dex

.class Landroidx/preferencecolor/SlidingSwitch$1;
.super Ljava/lang/Object;
.source "SlidingSwitch.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Landroidx/preferencecolor/SlidingSwitch;->onAttachedToWindow()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Landroidx/preferencecolor/SlidingSwitch;


# direct methods
.method constructor <init>(Landroidx/preferencecolor/SlidingSwitch;)V
    .registers 2

    iput-object p1, p0, Landroidx/preferencecolor/SlidingSwitch$1;->this$0:Landroidx/preferencecolor/SlidingSwitch;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .registers 2

    iget-object v0, p0, Landroidx/preferencecolor/SlidingSwitch$1;->this$0:Landroidx/preferencecolor/SlidingSwitch;

    invoke-virtual {v0}, Landroidx/preferencecolor/SlidingSwitch;->onPreferenceColorChange()V

    return-void
.end method

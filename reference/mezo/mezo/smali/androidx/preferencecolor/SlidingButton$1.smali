# classes10.dex

.class Landroidx/preferencecolor/SlidingButton$1;
.super Ljava/lang/Object;
.source "SlidingButton.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Landroidx/preferencecolor/SlidingButton;->onAttachedToWindow()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Landroidx/preferencecolor/SlidingButton;


# direct methods
.method constructor <init>(Landroidx/preferencecolor/SlidingButton;)V
    .registers 2

    iput-object p1, p0, Landroidx/preferencecolor/SlidingButton$1;->this$0:Landroidx/preferencecolor/SlidingButton;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .registers 2

    iget-object v0, p0, Landroidx/preferencecolor/SlidingButton$1;->this$0:Landroidx/preferencecolor/SlidingButton;

    invoke-virtual {v0}, Landroidx/preferencecolor/SlidingButton;->onPreferenceColorChange()V

    return-void
.end method

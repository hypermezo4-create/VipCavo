# classes10.dex

.class Landroidx/preferencecolor/PreferenceSeekBar$1;
.super Ljava/lang/Object;
.source "PreferenceSeekBar.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Landroidx/preferencecolor/PreferenceSeekBar;->onAttachedToWindow()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Landroidx/preferencecolor/PreferenceSeekBar;


# direct methods
.method constructor <init>(Landroidx/preferencecolor/PreferenceSeekBar;)V
    .registers 2

    iput-object p1, p0, Landroidx/preferencecolor/PreferenceSeekBar$1;->this$0:Landroidx/preferencecolor/PreferenceSeekBar;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .registers 2

    iget-object v0, p0, Landroidx/preferencecolor/PreferenceSeekBar$1;->this$0:Landroidx/preferencecolor/PreferenceSeekBar;

    invoke-virtual {v0}, Landroidx/preferencecolor/PreferenceSeekBar;->onPreferenceColorChange()V

    return-void
.end method

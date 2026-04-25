# classes10.dex

.class Lmiuix/settings/example/SeekBarDialog$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/SeekBar$OnSeekBarChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lmiuix/settings/example/SeekBarDialog;->init()Lmiuix/settings/example/SeekBarDialog;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lmiuix/settings/example/SeekBarDialog;


# direct methods
.method constructor <init>(Lmiuix/settings/example/SeekBarDialog;)V
    .registers 2

    iput-object p1, p0, Lmiuix/settings/example/SeekBarDialog$1;->this$0:Lmiuix/settings/example/SeekBarDialog;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onProgressChanged(Landroid/widget/SeekBar;IZ)V
    .registers 7

    iget-object v0, p0, Lmiuix/settings/example/SeekBarDialog$1;->this$0:Lmiuix/settings/example/SeekBarDialog;

    invoke-static {v0}, Lmiuix/settings/example/SeekBarDialog;->access$100(Lmiuix/settings/example/SeekBarDialog;)Landroid/widget/TextView;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lmiuix/settings/example/SeekBarDialog$1;->this$0:Lmiuix/settings/example/SeekBarDialog;

    invoke-static {v2}, Lmiuix/settings/example/SeekBarDialog;->access$000(Lmiuix/settings/example/SeekBarDialog;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "  "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lmiuix/settings/example/SeekBarDialog$1;->this$0:Lmiuix/settings/example/SeekBarDialog;

    invoke-static {v0}, Lmiuix/settings/example/SeekBarDialog;->access$200(Lmiuix/settings/example/SeekBarDialog;)Lmiuix/settings/example/SeekBarDialog$OnProgressChangeListener;

    move-result-object v0

    if-eqz v0, :cond_37

    iget-object v0, p0, Lmiuix/settings/example/SeekBarDialog$1;->this$0:Lmiuix/settings/example/SeekBarDialog;

    invoke-static {v0}, Lmiuix/settings/example/SeekBarDialog;->access$200(Lmiuix/settings/example/SeekBarDialog;)Lmiuix/settings/example/SeekBarDialog$OnProgressChangeListener;

    move-result-object v0

    invoke-interface {v0, p2}, Lmiuix/settings/example/SeekBarDialog$OnProgressChangeListener;->onProgressChange(I)V

    :cond_37
    return-void
.end method

.method public onStartTrackingTouch(Landroid/widget/SeekBar;)V
    .registers 2

    return-void
.end method

.method public onStopTrackingTouch(Landroid/widget/SeekBar;)V
    .registers 4

    iget-object v0, p0, Lmiuix/settings/example/SeekBarDialog$1;->this$0:Lmiuix/settings/example/SeekBarDialog;

    invoke-static {v0}, Lmiuix/settings/example/SeekBarDialog;->access$200(Lmiuix/settings/example/SeekBarDialog;)Lmiuix/settings/example/SeekBarDialog$OnProgressChangeListener;

    move-result-object v0

    if-eqz v0, :cond_15

    iget-object v0, p0, Lmiuix/settings/example/SeekBarDialog$1;->this$0:Lmiuix/settings/example/SeekBarDialog;

    invoke-static {v0}, Lmiuix/settings/example/SeekBarDialog;->access$200(Lmiuix/settings/example/SeekBarDialog;)Lmiuix/settings/example/SeekBarDialog$OnProgressChangeListener;

    move-result-object v0

    invoke-virtual {p1}, Landroid/widget/SeekBar;->getProgress()I

    move-result v1

    invoke-interface {v0, v1}, Lmiuix/settings/example/SeekBarDialog$OnProgressChangeListener;->onStopTouch(I)V

    :cond_15
    return-void
.end method

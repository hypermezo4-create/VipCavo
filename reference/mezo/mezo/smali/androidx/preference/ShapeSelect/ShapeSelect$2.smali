# classes10.dex

.class Landroidx/preference/ShapeSelect/ShapeSelect$2;
.super Ljava/lang/Object;
.source "ShapeSelect.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Landroidx/preference/ShapeSelect/ShapeSelect;->show()Lmiuix/appcompat/app/AlertDialog;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Landroidx/preference/ShapeSelect/ShapeSelect;


# direct methods
.method constructor <init>(Landroidx/preference/ShapeSelect/ShapeSelect;)V
    .registers 2

    iput-object p1, p0, Landroidx/preference/ShapeSelect/ShapeSelect$2;->this$0:Landroidx/preference/ShapeSelect/ShapeSelect;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .registers 3

    iget-object v0, p0, Landroidx/preference/ShapeSelect/ShapeSelect$2;->this$0:Landroidx/preference/ShapeSelect/ShapeSelect;

    invoke-static {v0}, Landroidx/preference/ShapeSelect/ShapeSelect;->access$000(Landroidx/preference/ShapeSelect/ShapeSelect;)Landroidx/preference/ShapeSelect/SwitchPanel;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/preference/ShapeSelect/SwitchPanel;->moveLeft()V

    return-void
.end method

# classes10.dex

.class Landroidx/preference/MiuiColorPicker/ColorPickerDialog$1;
.super Ljava/lang/Object;
.source "ColorPickerDialog.java"

# interfaces
.implements Landroid/widget/TextView$OnEditorActionListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->setUp(I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Landroidx/preference/MiuiColorPicker/ColorPickerDialog;


# direct methods
.method constructor <init>(Landroidx/preference/MiuiColorPicker/ColorPickerDialog;)V
    .registers 2

    iput-object p1, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog$1;->this$0:Landroidx/preference/MiuiColorPicker/ColorPickerDialog;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onEditorAction(Landroid/widget/TextView;ILandroid/view/KeyEvent;)Z
    .registers 11

    const/4 v0, 0x0

    const/4 v1, 0x6

    if-ne p2, v1, :cond_69

    invoke-virtual {p1}, Landroid/widget/TextView;->getContext()Landroid/content/Context;

    move-result-object v1

    const-string v2, "input_method"

    invoke-virtual {v1, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/view/inputmethod/InputMethodManager;

    invoke-virtual {p1}, Landroid/widget/TextView;->getWindowToken()Landroid/os/IBinder;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, Landroid/view/inputmethod/InputMethodManager;->hideSoftInputFromWindow(Landroid/os/IBinder;I)Z

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog$1;->this$0:Landroidx/preference/MiuiColorPicker/ColorPickerDialog;

    invoke-static {v0}, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->access$000(Landroidx/preference/MiuiColorPicker/ColorPickerDialog;)Landroid/widget/EditText;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    const/4 v3, 0x5

    const/4 v4, 0x1

    const/high16 v5, -0x10000

    if-le v2, v3, :cond_5f

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    const/16 v3, 0xa

    if-ge v2, v3, :cond_5f

    :try_start_37
    invoke-static {v0}, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->convertToColorInt(Ljava/lang/String;)I

    move-result v2

    iget-object v3, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog$1;->this$0:Landroidx/preference/MiuiColorPicker/ColorPickerDialog;

    invoke-static {v3}, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->access$100(Landroidx/preference/MiuiColorPicker/ColorPickerDialog;)Landroidx/preference/MiuiColorPicker/ColorPickerView;

    move-result-object v3

    invoke-virtual {v3, v2, v4}, Landroidx/preference/MiuiColorPicker/ColorPickerView;->setColor(IZ)V

    iget-object v3, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog$1;->this$0:Landroidx/preference/MiuiColorPicker/ColorPickerDialog;

    invoke-static {v3}, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->access$000(Landroidx/preference/MiuiColorPicker/ColorPickerDialog;)Landroid/widget/EditText;

    move-result-object v3

    iget-object v6, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog$1;->this$0:Landroidx/preference/MiuiColorPicker/ColorPickerDialog;

    invoke-static {v6}, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->access$200(Landroidx/preference/MiuiColorPicker/ColorPickerDialog;)Landroid/content/res/ColorStateList;

    move-result-object v6

    invoke-virtual {v3, v6}, Landroid/widget/EditText;->setTextColor(Landroid/content/res/ColorStateList;)V
    :try_end_53
    .catch Ljava/lang/IllegalArgumentException; {:try_start_37 .. :try_end_53} :catch_54

    goto :goto_5e

    :catch_54
    move-exception v2

    iget-object v3, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog$1;->this$0:Landroidx/preference/MiuiColorPicker/ColorPickerDialog;

    invoke-static {v3}, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->access$000(Landroidx/preference/MiuiColorPicker/ColorPickerDialog;)Landroid/widget/EditText;

    move-result-object v3

    invoke-virtual {v3, v5}, Landroid/widget/EditText;->setTextColor(I)V

    :goto_5e
    goto :goto_68

    :cond_5f
    iget-object v2, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog$1;->this$0:Landroidx/preference/MiuiColorPicker/ColorPickerDialog;

    invoke-static {v2}, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->access$000(Landroidx/preference/MiuiColorPicker/ColorPickerDialog;)Landroid/widget/EditText;

    move-result-object v2

    invoke-virtual {v2, v5}, Landroid/widget/EditText;->setTextColor(I)V

    :goto_68
    return v4

    :cond_69
    return v0
.end method

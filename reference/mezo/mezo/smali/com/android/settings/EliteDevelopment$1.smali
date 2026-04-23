# classes2.dex

.class Lcom/android/settings/EliteDevelopment$1;
.super Landroidx/recyclerview/widget/GridLayoutManager$SpanSizeLookup;


# instance fields
.field final synthetic a:I

.field final synthetic b:Lcom/android/settings/EliteDevelopment;


# direct methods
.method constructor <init>(Lcom/android/settings/EliteDevelopment;I)V
    .registers 3

    invoke-direct {p0}, Landroidx/recyclerview/widget/GridLayoutManager$SpanSizeLookup;-><init>()V

    iput-object p1, p0, Lcom/android/settings/EliteDevelopment$1;->b:Lcom/android/settings/EliteDevelopment;

    iput p2, p0, Lcom/android/settings/EliteDevelopment$1;->a:I

    return-void
.end method


# virtual methods
.method public getSpanSize(I)I
    .registers 3

    if-nez p1, :cond_5

    iget v0, p0, Lcom/android/settings/EliteDevelopment$1;->a:I

    return v0

    :cond_5
    const/4 v0, 0x1

    return v0
.end method

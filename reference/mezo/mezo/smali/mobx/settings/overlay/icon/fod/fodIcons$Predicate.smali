# classes10.dex

.class public final Lmobx/settings/overlay/icon/fod/fodIcons$Predicate;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/util/function/Predicate;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lmobx/settings/overlay/icon/fod/fodIcons;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x39
    name = "Predicate"
.end annotation


# static fields
.field public static INSTANCE:Lmobx/settings/overlay/icon/fod/fodIcons$Predicate;


# direct methods
.method static final constructor <clinit>()V
    .registers 1

    new-instance v0, Lmobx/settings/overlay/icon/fod/fodIcons$Predicate;

    invoke-direct {v0}, Lmobx/settings/overlay/icon/fod/fodIcons$Predicate;-><init>()V

    sput-object v0, Lmobx/settings/overlay/icon/fod/fodIcons$Predicate;->INSTANCE:Lmobx/settings/overlay/icon/fod/fodIcons$Predicate;

    return-void
.end method

.method public constructor <init>()V
    .registers 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final test(Ljava/lang/Object;)Z
    .registers 3

    check-cast p1, Landroid/content/om/OverlayInfo;

    invoke-virtual {p1}, Landroid/content/om/OverlayInfo;->isEnabled()Z

    move-result v0

    return v0
.end method

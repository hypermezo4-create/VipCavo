# classes10.dex

.class public final Lmobx/settings/overlay/icon/volte/VolteIcons$Function;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/util/function/Function;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lmobx/settings/overlay/icon/volte/VolteIcons;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x39
    name = "Function"
.end annotation


# static fields
.field public static INSTANCE:Lmobx/settings/overlay/icon/volte/VolteIcons$Function;


# direct methods
.method static final constructor <clinit>()V
    .registers 1

    new-instance v0, Lmobx/settings/overlay/icon/volte/VolteIcons$Function;

    invoke-direct {v0}, Lmobx/settings/overlay/icon/volte/VolteIcons$Function;-><init>()V

    sput-object v0, Lmobx/settings/overlay/icon/volte/VolteIcons$Function;->INSTANCE:Lmobx/settings/overlay/icon/volte/VolteIcons$Function;

    return-void
.end method

.method public constructor <init>()V
    .registers 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final apply(Ljava/lang/Object;)Ljava/lang/Object;
    .registers 3

    check-cast p1, Landroid/content/om/OverlayInfo;

    iget-object v0, p1, Landroid/content/om/OverlayInfo;->packageName:Ljava/lang/String;

    return-object v0
.end method

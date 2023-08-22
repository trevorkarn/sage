"""
Finite dimensional free algebra quotients

REMARK:

This implementation only works for finite dimensional quotients, since
a list of basis monomials and the multiplication matrices need to be
explicitly provided.

The homogeneous part of a quotient of a free algebra over a field by a
finitely generated homogeneous twosided ideal is available in a
different implementation. See
:mod:`~sage.algebras.letterplace.free_algebra_letterplace` and
:mod:`~sage.rings.quotient_ring`.

TESTS:

::

    sage: n = 2
    sage: A = FreeAlgebra(QQ,n,'x')
    sage: F = A.monoid()
    sage: i, j = F.gens()
    sage: mons = [ F(1), i, j, i*j ]
    sage: r = len(mons)
    sage: M = MatrixSpace(QQ,r)
    sage: mats = [M([0,1,0,0, -1,0,0,0, 0,0,0,-1, 0,0,1,0]), M([0,0,1,0, 0,0,0,1, -1,0,0,0, 0,-1,0,0]) ]
    sage: H2.<i,j> = A.quotient(mons,mats)
    sage: H2 == loads(dumps(H2))
    True
    sage: i == loads(dumps(i))
    True

Test comparison by equality::

    sage: HQ = sage.algebras.free_algebra_quotient.hamilton_quatalg(QQ)[0]
    sage: HZ = sage.algebras.free_algebra_quotient.hamilton_quatalg(ZZ)[0]
    sage: HQ == HQ
    True
    sage: HQ == HZ
    False
    sage: HZ == QQ
    False
"""

# ****************************************************************************
#  Copyright (C) 2005 David Kohel <kohel@maths.usyd.edu>
#
#  Distributed under the terms of the GNU General Public License (GPL)
#
#    This code is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty
#    of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#
#  See the GNU General Public License for more details; the full text
#  is available at:
#
#                  https://www.gnu.org/licenses/
# ****************************************************************************

from sage.modules.free_module import FreeModule
from sage.rings.ring import Algebra
from sage.algebras.free_algebra import is_FreeAlgebra
from sage.algebras.free_algebra_quotient_element import FreeAlgebraQuotientElement
from sage.structure.unique_representation import UniqueRepresentation
from sage.rings.noncommutative_ideals import Ideal_nc


class FreeAlgebraIdeal(Ideal_nc):
    def __init__(self, ring, gens, coerce=True, side="twosided"):
        Ideal_nc.__init__(self, ring, gens, coerce, side)

    def reduce(self, f):
        r"""
        Return the normal form of `f` modulo `self`.

        TESTS::

            sage: A.<x1,x2,x3> = FreeAlgebra(QQ)
            sage: I = A*[x1*x2 - x2*x3]*A
            sage: I.reduce(x1*x2*x3)
            x1^2*x2
        """
        GB = self.groebner_basis()
        rem = f
        R = self.ring()
        for g in GB:
            # get the leading monomial
            LM_G, LC_G = g.leading_item()

            # convert to a Word so that we can do substring comparison
            LM_GW = LM_G.to_word()

            # while any monomial of rem has a factor of LM_G
            while True:
                # get leading term of the remainder
                LM_rem, LC_rem = rem.leading_item()
                LM_remW = LM_rem.to_word()

                # if there is any substring, pick the first occurance of it
                # if there is not, move on
                try:
                    i0 = next(LM_remW.factor_occurrences_iterator(LM_GW))
                except StopIteration:
                    break

                # the left/right factors of the leading monomial after
                # factoring out the leading monomial of g.
                lefts = R.element_class(R, {LM_remW[:i0]: LC_rem/g.leading_coefficient()})
                rights = R.element_class(R, {LM_remW[i0+len(LM_GW):]: 1})

                # decrement the remainder
                rem = rem - lefts*g*rights

        return(rem)

    def groebner_basis(self, max_size=100):
        G = set(self.gens())
        counter = len(G)
        O = set()
        import itertools
        for f,g in itertools.combinations(G,2):
            if o := self._overlap_element(f,g):
                O.add(o)
            if o := self._overlap_element(g,f):
                O.add(o)
        while O:
            if counter >= max_size:
                warnings.warn(f"Only {max_size} elements have been computed. Please increase `max_size` or proceed with caution")
                return G
            o = O.pop()
            r = self.reduce_mod(o, G)
            if r:
                G = G.add(r)
                counter += 1
                try:
                    O.update([overlap_element(g,r) for g in G] + [overlap_element(r,g) for g in G])
                except TypeError:
                    continue
        return sorted(G)

class FreeAlgebraQuotient(UniqueRepresentation, Algebra, object):
    @staticmethod
    def __classcall__(cls, A, mons, mats, names):
        """
        Used to support unique representation.

        EXAMPLES::

            sage: H = sage.algebras.free_algebra_quotient.hamilton_quatalg(QQ)[0]  # indirect doctest
            sage: H1 = sage.algebras.free_algebra_quotient.hamilton_quatalg(QQ)[0]
            sage: H is H1
            True
        """
        new_mats = []
        for M in mats:
            M = M.parent()(M)
            M.set_immutable()
            new_mats.append(M)
        return super().__classcall__(cls, A, tuple(mons),
                                     tuple(new_mats), tuple(names))

    Element = FreeAlgebraQuotientElement

    def __init__(self, A, mons, mats, names):
        """
        Return a quotient algebra defined via the action of a free algebra
        A on a (finitely generated) free module.

        The input for the quotient algebra is a list of monomials (in
        the underlying monoid for A) which form a free basis for the
        module of A, and a list of matrices, which give the action of
        the free generators of A on this monomial basis.

        EXAMPLES:

        Quaternion algebra defined in terms of three generators::

            sage: n = 3
            sage: A = FreeAlgebra(QQ,n,'i')
            sage: F = A.monoid()
            sage: i, j, k = F.gens()
            sage: mons = [ F(1), i, j, k ]
            sage: M = MatrixSpace(QQ,4)
            sage: mats = [M([0,1,0,0, -1,0,0,0, 0,0,0,-1, 0,0,1,0]),  M([0,0,1,0, 0,0,0,1, -1,0,0,0, 0,-1,0,0]),  M([0,0,0,1, 0,0,-1,0, 0,1,0,0, -1,0,0,0]) ]
            sage: H3.<i,j,k> = FreeAlgebraQuotient(A,mons,mats)
            sage: x = 1 + i + j + k
            sage: x
            1 + i + j + k
            sage: x**128
            -170141183460469231731687303715884105728 + 170141183460469231731687303715884105728*i + 170141183460469231731687303715884105728*j + 170141183460469231731687303715884105728*k

        Same algebra defined in terms of two generators, with some penalty
        on already slow arithmetic.

        ::

            sage: n = 2
            sage: A = FreeAlgebra(QQ,n,'x')
            sage: F = A.monoid()
            sage: i, j = F.gens()
            sage: mons = [ F(1), i, j, i*j ]
            sage: r = len(mons)
            sage: M = MatrixSpace(QQ,r)
            sage: mats = [M([0,1,0,0, -1,0,0,0, 0,0,0,-1, 0,0,1,0]), M([0,0,1,0, 0,0,0,1, -1,0,0,0, 0,-1,0,0]) ]
            sage: H2.<i,j> = A.quotient(mons,mats)
            sage: k = i*j
            sage: x = 1 + i + j + k
            sage: x
            1 + i + j + i*j
            sage: x**128
            -170141183460469231731687303715884105728 + 170141183460469231731687303715884105728*i + 170141183460469231731687303715884105728*j + 170141183460469231731687303715884105728*i*j

        TESTS::

            sage: TestSuite(H2).run()

        """
        if not is_FreeAlgebra(A):
            raise TypeError("argument A must be an algebra")
        R = A.base_ring()
        n = A.ngens()
        assert n == len(mats)
        self.__free_algebra = A
        self.__ngens = n
        self.__dim = len(mons)
        self.__module = FreeModule(R, self.__dim)
        self.__matrix_action = mats
        self.__monomial_basis = mons  # elements of free monoid
        Algebra.__init__(self, R, names, normalize=True)

    def _element_constructor_(self, x):
        """
        EXAMPLES::

            sage: H, (i,j,k) = sage.algebras.free_algebra_quotient.hamilton_quatalg(QQ)
            sage: H(i) is i
            True
            sage: a = H._element_constructor_(1); a
            1
            sage: a in H
            True
            sage: a = H._element_constructor_([1,2,3,4]); a
            1 + 2*i + 3*j + 4*k
        """
        return self.element_class(self, x)

    def _coerce_map_from_(self, S):
        """
        EXAMPLES::

            sage: H, (i,j,k) = sage.algebras.free_algebra_quotient.hamilton_quatalg(QQ)
            sage: H._coerce_map_from_(H)
            True
            sage: H._coerce_map_from_(QQ)
            True
            sage: H._coerce_map_from_(GF(7))
            False
        """
        return S == self or self.__free_algebra.has_coerce_map_from(S)

    def _repr_(self):
        """
        EXAMPLES::

            sage: H, (i,j,k) = sage.algebras.free_algebra_quotient.hamilton_quatalg(QQ)
            sage: H._repr_()
            "Free algebra quotient on 3 generators ('i', 'j', 'k') and dimension 4 over Rational Field"
        """
        R = self.base_ring()
        n = self.__ngens
        r = self.__module.dimension()
        x = self.variable_names()
        return "Free algebra quotient on %s generators %s and dimension %s over %s" % (n, x, r, R)

    def gen(self, i):
        """
        The i-th generator of the algebra.

        EXAMPLES::

            sage: H, (i,j,k) = sage.algebras.free_algebra_quotient.hamilton_quatalg(QQ)
            sage: H.gen(0)
            i
            sage: H.gen(2)
            k

        An IndexError is raised if an invalid generator is requested::

            sage: H.gen(3)
            Traceback (most recent call last):
            ...
            IndexError: argument i (= 3) must be between 0 and 2

        Negative indexing into the generators is not supported::

            sage: H.gen(-1)
            Traceback (most recent call last):
            ...
            IndexError: argument i (= -1) must be between 0 and 2
        """
        n = self.__ngens
        if i < 0 or not i < n:
            raise IndexError("argument i (= %s) must be between 0 and %s" % (i, n - 1))
        R = self.base_ring()
        F = self.__free_algebra.monoid()
        return self.element_class(self, {F.gen(i): R.one()})

    def ngens(self):
        """
        The number of generators of the algebra.

        EXAMPLES::

            sage: sage.algebras.free_algebra_quotient.hamilton_quatalg(QQ)[0].ngens()
            3
        """
        return self.__ngens

    def dimension(self):
        """
        The rank of the algebra (as a free module).

        EXAMPLES::

            sage: sage.algebras.free_algebra_quotient.hamilton_quatalg(QQ)[0].dimension()
            4
        """
        return self.__dim

    def matrix_action(self):
        """
        EXAMPLES::

            sage: sage.algebras.free_algebra_quotient.hamilton_quatalg(QQ)[0].matrix_action()
            (
            [ 0  1  0  0]  [ 0  0  1  0]  [ 0  0  0  1]
            [-1  0  0  0]  [ 0  0  0  1]  [ 0  0 -1  0]
            [ 0  0  0 -1]  [-1  0  0  0]  [ 0  1  0  0]
            [ 0  0  1  0], [ 0 -1  0  0], [-1  0  0  0]
            )
        """
        return self.__matrix_action

    def monomial_basis(self):
        """
        The free monoid of generators of the algebra as elements of a free
        monoid.

        EXAMPLES::

            sage: sage.algebras.free_algebra_quotient.hamilton_quatalg(QQ)[0].monomial_basis()
            (1, i0, i1, i2)
        """
        return self.__monomial_basis

    def rank(self):
        """
        The rank of the algebra (as a free module).

        EXAMPLES::

            sage: sage.algebras.free_algebra_quotient.hamilton_quatalg(QQ)[0].rank()
            4
        """
        return self.__dim

    def module(self):
        """
        The free module of the algebra.

        EXAMPLES::

            sage: H = sage.algebras.free_algebra_quotient.hamilton_quatalg(QQ)[0]; H
            Free algebra quotient on 3 generators ('i', 'j', 'k') and dimension 4 over Rational Field
            sage: H.module()
            Vector space of dimension 4 over Rational Field
        """
        return self.__module

    def monoid(self):
        """
        The free monoid of generators of the algebra.

       EXAMPLES::

            sage: sage.algebras.free_algebra_quotient.hamilton_quatalg(QQ)[0].monoid()
            Free monoid on 3 generators (i0, i1, i2)
        """
        return self.__free_algebra.monoid()

    def free_algebra(self):
        """
        The free algebra generating the algebra.

        EXAMPLES::

            sage: sage.algebras.free_algebra_quotient.hamilton_quatalg(QQ)[0].free_algebra()
            Free Algebra on 3 generators (i0, i1, i2) over Rational Field
        """
        return self.__free_algebra


def hamilton_quatalg(R):
    """
    Hamilton quaternion algebra over the commutative ring R,
    constructed as a free algebra quotient.

    INPUT:

    - R -- a commutative ring

    OUTPUT:

    - Q -- quaternion algebra
    - gens -- generators for Q

    EXAMPLES::

        sage: H, (i,j,k) = sage.algebras.free_algebra_quotient.hamilton_quatalg(ZZ)
        sage: H
        Free algebra quotient on 3 generators ('i', 'j', 'k') and dimension 4 over Integer Ring
        sage: i^2
        -1
        sage: i in H
        True

    Note that there is another vastly more efficient models for
    quaternion algebras in Sage; the one here is mainly for testing
    purposes::

        sage: R.<i,j,k> = QuaternionAlgebra(QQ,-1,-1)  # much fast than the above
    """
    n = 3
    from sage.algebras.free_algebra import FreeAlgebra
    from sage.matrix.matrix_space import MatrixSpace
    A = FreeAlgebra(R, n, 'i')
    F = A.monoid()
    i, j, k = F.gens()
    mons = [F(1), i, j, k]
    M = MatrixSpace(R, 4)
    mats = [M([0, 1, 0, 0, -1, 0, 0, 0, 0, 0, 0, -1, 0, 0, 1, 0]),
            M([0, 0, 1, 0, 0, 0, 0, 1, -1, 0, 0, 0, 0, -1, 0, 0]),
            M([0, 0, 0, 1, 0, 0, -1, 0, 0, 1, 0, 0, -1, 0, 0, 0])]
    H3 = FreeAlgebraQuotient(A, mons, mats, names=('i', 'j', 'k'))
    return H3, H3.gens()

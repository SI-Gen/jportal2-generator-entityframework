<#-- @ftlvariable name="table" type="bbd.jportal2.Table" -->
<#import "basefunctions.ftl" as base>
// ########################################################################################################################
// ################## Generated Code. DO NOT CHANGE THIS CODE. Change it in the generator and regenerate ##################
// ########################################################################################################################
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using Bbd.Vanguard.${database.getServer()}.EntityFrameworkCore.Models;

namespace Bbd.Vanguard.${database.getServer()}.EntityFrameworkCore
{
    public interface I${database.getServer()}DbContext
    {
        <#list database.getTables() as table>
        DbSet<${table.name}Entity> ${table.name}Entity { get; set; }
        </#list>

        <#list database.getTables() as table>
        <#list table.procs as proc>
        <#if !proc.isStdExtended() && !proc.isSProc() && proc.name != "" && proc.name != "Identity" && proc.lines?size gt 0 && proc.outputs?size gt 0>
        <#--  SI Specific Implementation if ever needed?  -->
        <#--  <#if proc.isSingle()>Task<${table.name}_${proc.name}><#elseif proc.outputs?size gt 0>Task<IEnumerable<${table.name}_${proc.name}>><#else>Task</#if> Execute${table.name}_${proc.name}  -->
        IQueryable<${table.name}Entity_${proc.name}> ${table.name}Entity_${proc.name}(${base.getTypedFields(proc.inputs)});
        </#if>
        </#list>
        </#list>
    }
}